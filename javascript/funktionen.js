function onoff (show, hide) {
  if (document.getElementById) {
    document.getElementById(hide).style.visibility = "hidden";
    document.getElementById(show).style.visibility = "visible";
  }
}

function makeCentury(source, target){
 var sourceObjVal = document.getElementsByName(source)[0].value;
  var targetObj = document.getElementsByName(target)[0];
//  var targetObjSel = document.getElementsByName("Genauigkeit" + target)[0];
  var cent = 0;
  var text = "";
  if( (targetObj.value=="" || targetObj.value==0)){
   cent = ((sourceObjVal-1) - ((sourceObjVal-1)%100))/100 + 1;
   text = cent + "Jh";
   if (((sourceObjVal-1)%100)<50)   text = text + "1";
   else text = text + "2";
	  targetObj.value=text;

 //   if ((sourceObjVal%100)<50)   targetObjSel.value=6;
//   else targetObjSel.value=7
  }
}

function admin_copy(name) {
  document.getElementsByName(name+"_ID_alt")[0].value = document.getElementsByName(name)[0].value;
  document.getElementsByName(name+"_Bezeichnung_alt")[0].value = document.getElementsByName(name)[0].options[document.getElementsByName(name)[0].selectedIndex].text;
  document.getElementsByName(name+"_display_Bezeichnung_alt")[0].value = document.getElementsByName(name)[0].options[document.getElementsByName(name)[0].selectedIndex].text;

}

/*
 *   @param typ          Typ des Popups (search für Suche oder addselect)
 *   @param parent       Link zum "Elternfenster" des Popups
 *   @param table        Name der Tabelle in der Gesucht oder Eingefügt werden soll (Bei Selektionen ab _)
 *   @param destination  Name des Textfelds / der Selektion wo das Ergebnis hingeschrieben werden soll
 *   @param attribut     Attribut, nach dem gesucht werden soll (nur Suche)
 */
function popup(typ, parent, table, destination, attribut) {
  url = "";

  optionen = "height=300,location=no,menubar=no,resizable=no,scrollbars="+(typ=="search"?"yes":"no")+",status=no,toolbar=no,width=600";
  if (typ == "search") {
    url = "popups/search.jsp?form="+table+"&parent="+parent+"&destination="+destination+"&attribut="+attribut;
  }

  else if (typ == "addselect") {
    url = "popups/addselect.jsp?selektion="+table+"&parent="+parent+"&destination="+destination;
  }

  else if (typ == "changedate") {
    url = "popups/changedate.jsp?ID="+attribut+"&destination="+destination;
  }

  window.open(url, name, optionen);
}

function uploadFile(parent, table, attribute, id) {
  if (confirm(unescape("Bitte getrennt von anderen Eingaben hochladen. Alle bisherigen %C4nderungen in diesem Formular werden verworfen!"))) {
    url = "popups/uploadfile.jsp?table="+table+"&attribute="+attribute+"&ID="+id+"&parent="+parent;
    optionen = "height=300,location=no,menubar=no,resizable=no,scrollbars=no,status=no,toolbar=no,width=600";
    window.open(url, name, optionen);
  }
}

function addSelection (source_value, source_text, destination_select ) {
  var selection = opener.document.getElementsByName(destination_select)[0];
  
  var entry = new Option(source_text, source_value, false, true);
  selection.options[selection.length] = entry;
}

function copySearchedID(id, destination) {
  opener.document.getElementsByName(destination)[0].value = id;
}

function deleteEntry (table, id, returnpage, returnid) {
  if (confirm (unescape("Soll dieser Eintrag wirklich gel%F6scht werden? Alle bisherigen %C4nderungen in diesem Formular werden verworfen!"))) {
    location.href = "dodelete.jsp?table="+table+"&ID="+id+"&returnpage="+returnpage+"&returnid="+returnid;
  }
}

function deleteFile (table, attribute, id, returnpage) {
  if (confirm (unescape("Soll dieser Eintrag wirklich gel%F6scht werden? Alle bisherigen %C4nderungen in diesem Formular werden verworfen!"))) {
    location.href = "dodeletefile.jsp?table="+table+"&attribute="+attribute+"&ID="+id+"&returnpage="+returnpage;
  }
}

// Diese Methode berechnet die Zitierweise im Formular "Edition"
function generiereZitierweise() {
  var ziel = document.getElementsByName("Zitierweise")[0];
  var zw = "";

  for (i=0; document.getElementsByName("Editor["+i+"]")[0] != null; i++) {
    if (document.getElementsByName("Editor["+i+"]")[0].value > 1) {
      var eintrag = document.getElementsByName("Editor["+i+"]")[0].options[document.getElementsByName("Editor["+i+"]")[0].selectedIndex].text;
      zw += eintrag.substring(0, eintrag.indexOf(","))+" / ";
    }
  }
  zw = zw.substring(0, zw.lastIndexOf("/")-1);
  zw += " "+document.getElementsByName("Jahr")[0].value;
  ziel.value = zw;
}

// Diese Methode berechnet die Zitierweise im Formular "Edition"
function generiereZitierweiseLit() {
  var ziel = document.getElementsByName("Kurzzitierweise")[0];
  var zw = "";

  for (i=0; document.getElementsByName("AutorNachname["+i+"]")[0] != null && document.getElementsByName("AutorNachname["+i+"]")[0].value != ""; i++) {
    if (document.getElementsByName("AutorNachname["+i+"]")[0]!=null) {
      var nachname = document.getElementsByName("AutorNachname["+i+"]")[0].value;
      var vorname = document.getElementsByName("AutorVorname["+i+"]")[0].value;
      zw += vorname.substring(0, 1)+". ";
      zw += nachname +" / ";
    }
  }
  zw = zw.substring(0, zw.lastIndexOf("/")-1);
  if(zw.substring(zw.length-1, zw.length)==".")zw=zw.substring(zw.length-2, zw.length);
  if(zw!="") zw += ","
  var titel = document.getElementsByName("Titel")[0].value.split(" ");
  for (i=0; i<Math.min(titel.length,5); i++){
     zw += " " + titel[i];
  }
  if(zw!="")zw += ", ";
  zw +=  document.getElementsByName("Jahr")[0].value;
 
  ziel.value = zw;
}

// Diese Methode ändert die Angezeigte URL ins Format "?ID=..:"
function urlRewrite(id) {
  if(location.search.length == 0)
    location.replace('http://'+window.location.hostname+':'+window.location.port+window.location.pathname+'?ID='+id);
}
