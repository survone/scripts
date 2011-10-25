#!/usr/bin/ruby

# Define variables
host= ""

# Determine command line arguments
ARGV.each do|a|
  host += "#{a} "
end

# Cache original host
original_host = host.gsub(" ","")

# Remove 'www.'s from SSH hostname (not necessary)
host = host.gsub("www.", "")

# Remove any spaces
host = host.gsub(" ","")

# Remove HTTP tags
host = host.gsub("http://","")
host = host.gsub("https://","")

# Remove helpdesk triangle junk
host = host.gsub("»","")

# Check for @ symbols
if host.include?("@")
	# Remove email prefix
	host = host.split('@')
	
	# Set hostname
	host = host[1]
end

# Check for ports
if host.include?(":")
        # Remove port
        host = host.split(':')

        # Set hostname
        host = host[0]
end

# Strip out post-domain gubbins
if host.include?("/")
	# Remove gubbins
	host = host.split('/')

	# Set hostname
	host = host[0]
end

# Convert hostname to lower case
host.downcase!

# Print hostname
if host != original_host
	puts
	puts "Original: " + original_host
	puts "Corrected: " + host
	puts
end

# Establish SSH connection
exec "ssh root@" + host
