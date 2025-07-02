var Global = {
    db: null,
    activeInitial: null,
    initials: null,
    clipboard: null,
    scrollTimer: null,
    groupedEntries: null
};

// ----------------------------------------------------------------------------
function setHighlight(e) {
// ----------------------------------------------------------------------------
    let cur = $('.highlight');
    if(!cur.is(e)) {
        cur.removeClass('highlight');
        e.addClass('highlight');
    }
    return e;
}

// ----------------------------------------------------------------------------
function lemmaClicked() {
// ----------------------------------------------------------------------------
    let span = $(this);
    let input = $('<input/>').attr({
        type: 'text',
        value: span.text()
    }).css({
        width: span.outerWidth()
    }).on('keydown', (e) => {
        if(![13, 27].includes(e.keyCode))
            return;
        if(e.keyCode === 13) { // ENTER
            updateLemma(span.parents('.entry'), newLemma => {
                if(newLemma === false)
                    return;
                setLemmaDone(span.parents('.entry').find('.korr > a'), () => {
                    span.text(newLemma).show();
                    input.remove();
                });
            });
            e.stopPropagation();
        }
        else if(e.keyCode === 27) { // ESCAPE
            input.remove();
            span.show();
        }
    });
    setHighlight(span).hide();
    span.after(input);
    input.focus();
}

// ----------------------------------------------------------------------------
function setClipboardText(text) {
// ----------------------------------------------------------------------------
    Global.clipboard = text;
    $('#clipboardText').text(text);
}

// ----------------------------------------------------------------------------
function clipboardClicked() {
// ----------------------------------------------------------------------------
    let a = $(this);
    if(a.text() === 'K') {
        if(!Global.clipboard) {
            $('.clip > a').each(function() {
                let a = $(this);
                if(a.text() === 'E')
                    a.attr({ href: 'javascript:void(0)' }).click(clipboardClicked);
            });
        }
        setClipboardText(a.parents('.entry').find('.lemma').first().text());
        console.log('Copied "' + Global.clipboard + '" to clipboard');
    }
    else {
        let input = a.parents('.entry').find('input');
        if(input.length === 1) {
            input.val(Global.clipboard);
            input.focus();
        }
        else {
            let span = a.parents('.entry').find('.lemma');
            let curLemma = span.text();
            span.text(Global.clipboard);
            updateLemma(span.parents('.entry'), newLemma => {
                if(newLemma === false) {
                    span.text(curLemma);
                    return;
                }
                setLemmaDone(span.parents('.entry').find('.korr > a'), () => {
                    span.text(newLemma).show();
                });
            });

        }
        console.log('Pasted "' + Global.clipboard + '" from clipboard');
    }
}

// ----------------------------------------------------------------------------
function getEntryFromRow(row) {
// ----------------------------------------------------------------------------
    let id = Number(row.get(0).id.substr(1)); // id is "eXXX"
    let entry = Global.groupedEntries[id];
    return {
        key: id,
        korr: entry.korr,
        lemma: row.find('input').length === 1
            ? row.find('input').val().trim()
            : row.find('.lemma').text().trim(),
        beleg: entry.beleg,
        list: entry.list
    }
}

// ----------------------------------------------------------------------------
function updateEntryFromRow(row) {
// ----------------------------------------------------------------------------
    let id = Number(row.get(0).id.substr(1)); // id is "eXXX"
    let entry = Global.groupedEntries[id];
    entry.korr = row.find('.korr > a').length === 0;
    entry.lemma = row.find('.lemma').text();
    entry.beleg = row.find('.beleg').text();
}

// ----------------------------------------------------------------------------
function updateLemma(row, callback) {
// ----------------------------------------------------------------------------
    row.find('input').prop('disabled', true);
    let entry = getEntryFromRow(row);
    console.log('Updating lemma...', entry);
    $.post('../server/LemmaKorr.php', {
        method: 'updateLemma',
        value: entry.lemma,
        list: JSON.stringify(entry.list)
    }, (response) => {
        if(response.error || response.result === false) {
            console.error('ERROR when updating lemma: ', response.error);
            row.find('input').prop('disabled', false);
            callback && callback(false);
            return;
        }
        console.log('...DONE');
        callback(entry.lemma);
    }).fail(() => {
        console.error('ERROR when updating lemma: Request failed');
        callback(false);
    });
}    

// ----------------------------------------------------------------------------
function hideLemmasDone() {
// ----------------------------------------------------------------------------
    $('#list').hide();
    $('.entry.done').hide();
    let entry = $('.done:has(.highlight)');
    while(entry.length === 1) {
        entry = entry.next('.entry');
        if(entry.hasClass('open')) {
            setHighlight(entry.find('.lemma'));
            break;
        }
    }
    $('#list').show();
}

// ----------------------------------------------------------------------------
function showLemmasDone() {
// ----------------------------------------------------------------------------
    $('#list').hide();
    $('.entry.done').show();
    $('#list').show();
}

// ----------------------------------------------------------------------------
function updateCountAfterKorrektur() {
// ----------------------------------------------------------------------------
    let initialBtn = $('#initials button.active'),
        todoBox = $('#todoCount'),
        korrBox = $('#korrCount');
    todoBox.data('count', todoBox.data('count') - 1).text(Number(todoBox.data('count').toLocaleString()));
    korrBox.data('count', korrBox.data('count') + 1).text(Number(korrBox.data('count').toLocaleString()));
    if(todoBox.data('count') === 0)
        initialBtn.addClass('complete');
}

// ----------------------------------------------------------------------------
function setLemmaDone(a, callback) {
// ----------------------------------------------------------------------------
    if(a.length === 0) {
        callback && callback();
        return;
    }
    let row = a.parents('.entry');
    let entry = getEntryFromRow(row);
    if(entry.korr) { // already done
        callback && callback();
        return;
    }
    console.log('Setting lemma done...', entry);
    $.post('../server/LemmaKorr.php', {
        method: 'setLemmaKorr',
        value: 'true',
        list: JSON.stringify(entry.list)
    }, (response) => {
        if(response.error || response.result === false) {
            console.error('ERROR when setting lemma as corrected: ', response.error);
            return;
        }
        console.log('...DONE');
        a.parents('.entry').removeClass('open').addClass('done');
        a.parents('span').text(a.text());
        callback && callback(); 
        updateCountAfterKorrektur();
        updateEntryFromRow(row);
    }).fail(() => {
        console.error('ERROR when setting lemma as corrected: Request failed');
    });
}

// ----------------------------------------------------------------------------
function lemmaDoneClicked() {
// ----------------------------------------------------------------------------
    setLemmaDone($(this));
}

// ----------------------------------------------------------------------------
function _renderListInternal(listContainer, list) {
// ----------------------------------------------------------------------------
    $(window).off('resize');
    console.log('Rendering lemmas...');
    let f = document.createDocumentFragment();
    let todoCount = 0;
    let prevEntry = {};
    Global.groupedEntries = [];
    let allKorr = true;
    list.forEach(entry => {
        if(prevEntry.korr === entry.korr
            && prevEntry.lemma === entry.lemma
            && prevEntry.beleg === entry.beleg
        ) {
            prevEntry.list.push({id: entry.id, db: entry.db});
        }
        else {
            if(!entry.korr)
                allKorr = false;
            Global.groupedEntries.push(prevEntry = {
                lemma: entry.lemma,
                beleg: entry.beleg,
                korr: entry.korr,
                list: [{id: entry.id, db: entry.db}]
            });
        }
    });
    Global.groupedEntries.forEach((entry, key) => {
        let korr = entry.korr 
            ? '✓' 
            : "<a href='javascript:void(0)'>✓</a>";
        let korrCss = entry.korr ? 'done' : 'open';
        if(!entry.korr)
            todoCount++;
        let e = document.createElement('div');
        e.id = 'e' + key;
        e.className = `entry ${korrCss}`;
        if(entry.korr && !allKorr)
            e.style.display = 'none';
        e.innerHTML = 
            `<span class="korr">${korr}</span>
            <span class="clip">
                <a>K</a>
                <a>E</a>
            </span>
            <span class="lemma">${entry.lemma}</span>
            <span class="beleg">${entry.beleg}</span>
            <span class="list">${entry.list.length} Beleg(e)</span>`;
        f.appendChild(e);
    });
    listContainer.empty();
    listContainer[0].appendChild(f);
    $('.lemma').click(lemmaClicked);
    $('.entry').each(function() {
        if(this.style.display !== 'none') {
            setHighlight($(this).find('.lemma'));
            return false;
        }
    });
    if(typeof Global.clipboard === 'string') {
        $('.clip > a').attr({ href: 'javascript:void(0)' }).click(clipboardClicked);
    }
    else {
        $('.clip > a').each(function() {
            let a = $(this);
            if(a.text() === 'K')
                a.attr({ href: 'javascript:void(0)' }).click(clipboardClicked);
        });
    }
    $('.korr > a').click(lemmaDoneClicked);
    renderErledigteToggle(Global.groupedEntries.length, todoCount);
    $(window).deferredResize(windowResized, 250);
    windowResized();
    console.log('...DONE');
}

// ----------------------------------------------------------------------------
function renderList(btn) {
// ----------------------------------------------------------------------------
    $('#erledigteToggle').remove();
    let listContainer = $('#list').empty().text('LISTE LÄDT...');
    console.log('Fetching lemmas...');
    $.post('../server/LemmaKorr.php', {
        method: 'getFromInitial',
        initial: btn.data('initial')
    }, (response) => {
        _renderListInternal(listContainer, response.result);    
    });
}

// ----------------------------------------------------------------------------
function initialClicked() {
// ----------------------------------------------------------------------------
    let btn = $(this);
    if(Global.activeInitial) {
        if(Global.activeInitial.data('initial') === btn.data('initial'))
            return;
        Global.activeInitial.removeClass('active');
    }
    btn.addClass('active');
    Global.activeInitial = btn;
    renderList(btn);
}

// ----------------------------------------------------------------------------
function renderErledigteToggle(totalCount, todoCount) {
// ----------------------------------------------------------------------------
    $('#erledigteToggle').remove();
    $('#initials').after(
        $('<p/>').attr({id: 'erledigteToggle'})
            .append('Korrigierte Lemmata: ')
            .append($('<button/>').text('ausblenden').click(hideLemmasDone))
            .append($('<button/>').text('einblenden').click(showLemmasDone))
            .append($('<span/>').css({'margin-left': '1.5rem', 'margin-right': '0.5rem'}).text('Interne Zwischenablage:'))
            .append($('<span/>').attr({ id: 'clipboardText' }).text(typeof Global.clipboard === 'string' ? Global.clipboard : '---')).append($('<span/>').css({'margin-left': '1.5rem', 'margin-right': '0.5rem'})
                .append('Gesamt <span id="totalCount"></span> | Korrigiert <span id="korrCount"></span> | Offen <span id="todoCount"></span>')
            )
    );
    $('#totalCount').data('count', totalCount).text(Number(totalCount).toLocaleString());
    $('#todoCount').data('count', todoCount).text(Number(todoCount).toLocaleString());
    $('#korrCount').data('count', totalCount - todoCount).text(Number(totalCount - todoCount).toLocaleString());
}

// ----------------------------------------------------------------------------
function renderInitials() {
// ----------------------------------------------------------------------------
    let div = $('#initials').empty();
    
    Object.keys(Global.initials).forEach(i => {
        div.append(
            $('<button/>')
                .text(i == '' ? '(leer)' : i)
                .data({
                    initial: i
                })
                .addClass(Global.initials[i] === 0 ? 'complete' : '')
                .click(initialClicked)
        );
    });
}

// ----------------------------------------------------------------------------
function windowResized() {
// ----------------------------------------------------------------------------
    let div = $('#list');
    div.css({ 
        height: Math.max(100, window.innerHeight - div.offset().top - 28)
    });    
}

// ----------------------------------------------------------------------------
function scrollToRow(row) {
// ----------------------------------------------------------------------------
    if(Global.scrollTimer)
        clearTimeout(Global.scrollTimer);
    Global.scrollTimer = setTimeout(() => {
        let list = $('#list');
        let nt = row.offset().top,
            nh = row.height(),
            st = list.scrollTop(),
            dt = list.offset().top,
            dh = list.height();
        if(nt < dt || nt + nh > dt + dh) {
            list.animate({
                scrollTop: st + nt - dt - dh / 2 // scroll to middle of the tree
            }, 'fast');
        }
        Global.scrollTimer = null;
    }, 150);
}

// ----------------------------------------------------------------------------
function isTextSelected() {
// ----------------------------------------------------------------------------
    let sel;
    if(window.getSelection)
        sel = window.getSelection();
    else if(document.getSelection)
        sel = document.getSelection();
    else if(document.selection)
        sel = document.selection;
    if(!sel)
        return false;
    return typeof sel.type === 'string' && sel.type.toUpperCase() === 'RANGE';
}

// ----------------------------------------------------------------------------
function documentKeyDown(e) {
// ----------------------------------------------------------------------------
    let cur = $('.highlight');
    if(cur.length === 0)
        return;
    let curEntry = cur.parents('.entry');
    if([38, 40].includes(e.keyCode)) {
        if(curEntry.find('input').length > 0) // ignore
            return;
        e.preventDefault();
        let win;
        if(e.keyCode === 38) { // UP
            while(curEntry.length > 0) {
                curEntry = curEntry.prev();
                if(curEntry.css('display') === 'none')
                    continue;
                win = curEntry;
                break;   
            }
        }
        else if(e.keyCode === 40) {// DOWN
            while(curEntry.length > 0) {
                curEntry = curEntry.next();
                if(curEntry.css('display') === 'none')
                    continue;
                win = curEntry;
                break;   
            }
        }
        if(win && win.length === 1) {
            setHighlight(win.find('.lemma'));
            win.find('input').focus();
            scrollToRow(win);
        }
        e.stopPropagation();
    }
    else if(e.keyCode === 13) { // ENTER
        if(e.ctrlKey === true) { // set as done
            setLemmaDone(cur.parents('.entry').find('.korr > a'));
        }
        else if(cur.parents('.entry').find('input').length === 0) {
            cur.trigger('click'); // change to input mode
        }
    }
    /*else if(e.key === 'k' && e.ctrlKey === true && !isTextSelected()) {
        if(cur.parents('.entry').find('input').length > 0 && cur.parents('.entry').find('input').is(':focus'))
            return;
        cur.parents('.entry').find('a:contains("K")').trigger('click');
    }
    else if(e.key === 'e' && e.ctrlKey === true && !isTextSelected()) {
        let input = cur.parents('.entry').find('input');
        if(typeof Global.clipboard === 'string' && input.length === 1 && input.is(':focus')) {
            input.val(Global.clipboard);
            e.preventDefault();
            e.stopPropagation();
        }
        else {
            cur.parents('.entry').find('a:contains("E")').trigger('click');
        }
    }*/
}

// ----------------------------------------------------------------------------
function initUi() {
// ----------------------------------------------------------------------------
    $(document).on('keydown', documentKeyDown);
}

// ----------------------------------------------------------------------------
$(document).ready(() => {
// ----------------------------------------------------------------------------
    if($('form').length > 0) {
        // auth form displayed
        return;
    }
    console.log('Loading initials...');
    $.post('../server/LemmaKorr.php', {
        method: 'getAllInitials'
    }, response => {
        console.log('...DONE');
        Global.initials = response.result;
        initUi();
        renderInitials();
        setInterval(() => {
            console.log('Keeping session alive...');
            $.post('../server/LemmaKorr.php', {
                method: 'keepAlive'
            });
        }, 300000);
    });
});