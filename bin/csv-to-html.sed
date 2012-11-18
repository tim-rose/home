#!/usr/bin/sed -f
#
# csv-to-html.sed --convert some CSV text into HTML
#
1i\
<table><thead>
#
s|^|<tr><td>|
s|,|</td><td>|g
s|$|</td></tr>|g
#
1s|<td>|<th>|g
1s|</td>|</th>|g
#
1a\
</thead><tbody>
$a\
</tbody></table>
