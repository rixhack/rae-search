#encoding: utf-8
require 'rubygems'
require 'nokogiri'
require 'net/http'
require 'uri'
require 'open-uri'
require 'typhoeus'
require 'xmlsimple'
require 'cgi'
class Word
    def initialize(name, meanings)
        @name = name
        @meanings = meanings
    end
end

class Meaning
    def initialize(gender, number,definition)
        @gender = gender
        @number = number
        @definition = definition
    end
end

print "Enter a word: "
word=gets.strip

uri = URI("http://lema.rae.es/drae/srv/search?val=".concat(word))
puts uri

def getWord(w)
lw = w.split('</span>')
return lw[0].concat(lw[1]).concat(lw[2])
end
response = Typhoeus::Request.post(uri, :body =>"TS014dfc77_id=3&TS014dfc77_cr=3a0cccc0e1e18f9816e77a55adeea6cb%3Awvxx%3AVfQv4eTk%3A1795735522&TS014dfc77_76=0&TS014dfc77_86=0&TS014dfc77_md=1&TS014dfc77_rf=0&TS014dfc77_ct=0&TS014dfc77_pd=0")
s=response.body
l = s.split("Todos los derechos reservados")
print l.length-1," words found: \n"
l[0]=l[0].split('<body>')[1]
l.pop

for w in l do
 w=w.gsub("</p>","\n")
 html_doc = CGI::unescapeHTML(w.gsub(/<\/?[^>]*>/,""))
 html_doc = html_doc.split("Real Academia")[0]
 puts html_doc
end
