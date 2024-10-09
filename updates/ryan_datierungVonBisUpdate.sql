
UPDATE einzelbeleg
SET
    VonTag = IF(VonTag IS NULL OR VonTag = '', 0, VonTag),
    VonMonat = IF(VonMonat IS NULL OR VonMonat = '', 0, VonMonat),
    VonJahr = IF(VonJahr IS NULL OR VonJahr = '', 0, VonJahr),
    VonJahrhundert = IF(VonJahrhundert IS NULL OR VonJahrhundert = '', '0', VonJahrhundert),
    BisTag = IF(BisTag IS NULL OR BisTag = '', 0, BisTag),
    BisMonat = IF(BisMonat IS NULL OR BisMonat = '', 0, BisMonat),
    BisJahr = IF(BisJahr IS NULL OR BisJahr = '', 0, BisJahr),
    BisJahrhundert = IF(BisJahrhundert IS NULL OR BisJahrhundert = '', '0', BisJahrhundert),
    QuelleBisTag = IF(QuelleBisTag IS NULL OR QuelleBisTag = '', 0, QuelleBisTag),
    QuelleBisMonat = IF(QuelleBisMonat IS NULL OR QuelleBisMonat = '', 0, QuelleBisMonat),
    QuelleBisJahr = IF(QuelleBisJahr IS NULL OR QuelleBisJahr = '', 0, QuelleBisJahr),
    QuelleBisJahrhundert = IF(QuelleBisJahrhundert IS NULL OR QuelleBisJahrhundert = '', '0', QuelleBisJahrhundert),
    QuelleVonTag = IF(QuelleVonTag IS NULL OR QuelleVonTag = '', 0, QuelleVonTag),
    QuelleVonMonat = IF(QuelleVonMonat IS NULL OR QuelleVonMonat = '', 0, QuelleVonMonat),
    QuelleVonJahr = IF(QuelleVonJahr IS NULL OR QuelleVonJahr = '', 0, QuelleVonJahr),
    QuelleVonJahrhundert = IF(QuelleVonJahrhundert IS NULL OR QuelleVonJahrhundert = '', '0', QuelleVonJahrhundert)
WHERE
    VonTag IS NULL OR VonTag = ''
    OR VonMonat IS NULL OR VonMonat = ''
    OR VonJahr IS NULL OR VonJahr = ''
    OR VonJahrhundert IS NULL OR VonJahrhundert = ''
    OR BisTag IS NULL OR BisTag = ''
    OR BisMonat IS NULL OR BisMonat = ''
    OR BisJahr IS NULL OR BisJahr = ''
    OR BisJahrhundert IS NULL OR BisJahrhundert = ''
    OR QuelleBisTag IS NULL OR QuelleBisTag = ''
    OR QuelleBisMonat IS NULL OR QuelleBisMonat = ''
    OR QuelleBisJahr IS NULL OR QuelleBisJahr = ''
    OR QuelleBisJahrhundert IS NULL OR QuelleBisJahrhundert = ''
    OR QuelleVonTag IS NULL OR QuelleVonTag = ''
    OR QuelleVonMonat IS NULL OR QuelleVonMonat = ''
    OR QuelleVonJahr IS NULL OR QuelleVonJahr = ''
    OR QuelleVonJahrhundert IS NULL OR QuelleVonJahrhundert = '';

UPDATE quelle
SET
    VonTag = IF(VonTag IS NULL OR VonTag = '', 0, VonTag),
    VonMonat = IF(VonMonat IS NULL OR VonMonat = '', 0, VonMonat),
    VonJahr = IF(VonJahr IS NULL OR VonJahr = '', 0, VonJahr),
    VonJahrhundert = IF(VonJahrhundert IS NULL OR VonJahrhundert = '', '0', VonJahrhundert),
    BisTag = IF(BisTag IS NULL OR BisTag = '', 0, BisTag),
    BisMonat = IF(BisMonat IS NULL OR BisMonat = '', 0, BisMonat),
    BisJahr = IF(BisJahr IS NULL OR BisJahr = '', 0, BisJahr),
    BisJahrhundert = IF(BisJahrhundert IS NULL OR BisJahrhundert = '', '0', BisJahrhundert)
WHERE
    VonTag IS NULL OR VonTag = ''
    OR VonMonat IS NULL OR VonMonat = ''
    OR VonJahr IS NULL OR VonJahr = ''
    OR VonJahrhundert IS NULL OR VonJahrhundert = ''
    OR BisTag IS NULL OR BisTag = ''
    OR BisMonat IS NULL OR BisMonat = ''
    OR BisJahr IS NULL OR BisJahr = ''
    OR BisJahrhundert IS NULL OR BisJahrhundert = '';

UPDATE handschrift_ueberlieferung
SET
    VonTag = IF(VonTag IS NULL OR VonTag = '', 0, VonTag),
    VonMonat = IF(VonMonat IS NULL OR VonMonat = '', 0, VonMonat),
    VonJahr = IF(VonJahr IS NULL OR VonJahr = '', 0, VonJahr),
    VonJahrhundert = IF(VonJahrhundert IS NULL OR VonJahrhundert = '', '0', VonJahrhundert),
    BisTag = IF(BisTag IS NULL OR BisTag = '', 0, BisTag),
    BisMonat = IF(BisMonat IS NULL OR BisMonat = '', 0, BisMonat),
    BisJahr = IF(BisJahr IS NULL OR BisJahr = '', 0, BisJahr),
    BisJahrhundert = IF(BisJahrhundert IS NULL OR BisJahrhundert = '', '0', BisJahrhundert)
WHERE
    VonTag IS NULL OR VonTag = ''
    OR VonMonat IS NULL OR VonMonat = ''
    OR VonJahr IS NULL OR VonJahr = ''
    OR VonJahrhundert IS NULL OR VonJahrhundert = ''
    OR BisTag IS NULL OR BisTag = ''
    OR BisMonat IS NULL OR BisMonat = ''
    OR BisJahr IS NULL OR BisJahr = ''
    OR BisJahrhundert IS NULL OR BisJahrhundert = '';
