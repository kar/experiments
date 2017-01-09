#!/usr/bin/env ruby
#by St3ffn
def lineBeginsWithDate(value)
	if /^\d+\p{Space}[a-zA-Z]+\p{Space}\d+/=~ value
		return true
	else
		return false
	end
end

def lineBeginsWithLocation(value)
	if /^[a-zA-ZäÄöÖåÅ]+[a-zA-ZäÄöÖåÅ ]+/=~ value
		return true
	else
		return false
	end
end

def getDateFromLine(value) 
	return value.match(/^\d+\p{Space}[a-zA-Z]+\p{Space}\d+/)
end

def getReasonFromLine(value)
	tmp = value.match(/[a-zA-ZäÄöÖåÅ]+[a-zA-ZäÄöÖåÅ ]+av/)
	tmpStr = tmp.to_s().chop.chop

	return tmpStr
end

def getPersonFromLine(value)
	return value.match(/Karol Gusak$/)
end

def getLocationFromLine(value)
	tmp = value.match(/^[a-zA-ZäÄöÖåÅ]+[a-zA-ZäÄöÖåÅ ]+[a-zA-ZäÄöÖåÅ]+/)
	return tmp
end

def getAmountFromLine(value)
	tmp = value.match(/-\d+,\d+ kr$/)
	return tmp
end

class Entry
	@date
	def date=(value)
		@date = value
	end
	def date
		return @date
	end
	@reason
	def reason=(value)
		@reason = value
	end
	def reason
		return @reason
	end
	@person
	def person=(value)
		@person = value
	end
	def person
		return @person
	end
	@location
	def location=(value)
		@location = value
	end
	def location
		return @location
	end
	@amount
	def amount=(value)
		@amount = value
	end
	def amount
		return @amount
	end
	def printAll
		print @date
		print ";"
		print @reason
		print ";"
		print @person
		print ";"
		print @location 
		print ";" 
		print @amount
		print "\n"
	end
end

def printHelp() 
	puts "Greetings St3ffn"
	puts "Usage: \"#{$0} $file\""
end

path_to_file = ""

if ARGV.empty? || ARGV.length != 1
	printHelp
	exit
else
	path_to_file = ARGV[0]
end

if ! File.exist?(path_to_file)
	puts "ERROR: File doesn't exist"
	puts ""
	printHelp
	exit
end

entries = Array.new
entry_begins=true
entry_endet = false
entry_last_date = ""
entry = Entry.new

line_num=0

text=File.open(path_to_file).read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
	if lineBeginsWithDate(line)
		entry = Entry.new

		entry.date = getDateFromLine(line)
		entry_last_date = entry.date
		entry.reason = getReasonFromLine(line)
		entry.person = getPersonFromLine(line)
		entry_begins = true

	elsif lineBeginsWithLocation(line) && entry_begins
		entry.location = getLocationFromLine(line)
		entry.amount = getAmountFromLine(line)
		entries << entry
		entry_begins = false
	elsif lineBeginsWithLocation(line) && !entry_begins
		entry = Entry.new
		entry.date = entry_last_date
		entry.reason = getReasonFromLine(line)
		entry.person = getPersonFromLine(line)
		entry_begins = true

		entry_begins=true
	end


  #print "#{line_num += 1} #{line}"
end

entries.each { |entry| print entry.printAll }




