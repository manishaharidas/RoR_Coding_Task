require 'rexml/document'
require 'mysql'
begin
  con=Mysql.new 'localhost', 'manisha', 'root', 'mydb'
  puts con.get_server_info
  rs=con.query 'SELECT VERSION()'
  puts rs.fetch_row  
end
include REXML
file = File.new("sitemap.xml")
doc = Document.new(file)
doc.elements.each("*/url"){ |url|
print url.elements["loc"].text()
print "\t\t"
puts url.elements["priority"].text()
}
con.query("CREATE TABLE IF NOT EXISTS \ SITEMAP(ID INT PRIMARY KEY AUTO_INCREMENT, LOC VARCHAR(40),PRIORITY FLOAT)")
doc.elements.each("*/url"){ |url|
loc=url.elements["loc"].text()
priority=url.elements["priority"].text()
con.query("INSERT INTO SITEMAP VALUES(' ','#{loc}','#{priority}')")
}
data=con.query("SELECT * FROM SITEMAP")
data.each_hash do |d|
print d['LOC']
print "\t\t\t\t"
puts d['PRIORITY']
end
