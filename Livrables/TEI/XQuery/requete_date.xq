declare namespace tei="http://www.tei-c.org/ns/1.0";
for $date in distinct-values( doc("db/TEI_HDSLXB.xml")//tei:date/text())
order by $date
return $date
