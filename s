#!/usr/bin/ruby

# Define variables
host= ''

# Determine command line arguments
ARGV.each do|a|
  host += "#{a} "
end

# Remove any spaces
host = host.gsub(/\s/,'')

# Cache original host
original_host = host

# Remove HTTP tags
host = host.gsub(/(http|https|ftp):\/\//,'')

# Remove helpdesk triangle
host = host.gsub('»','')

# Check for @ symbols
if host.include?('@')
	# Remove email prefix
	host = host.split('@')
	
	# Set hostname
	host = host[1]
end

# Check for ports
if host.include?(':')
        # Remove port
        host = host.split(':')

        # Set hostname
        host = host[0]
end

# Strip out post-domain gubbins
if host.include?('/')
	# Remove gubbins
	host = host.split('/')

	# Set hostname
	host = host[0]
end

# Convert hostname to lower case
host.downcase!

# Print hostname
if host != original_host
	puts "\nOriginal: #{original_host}\nCorrected: #{host}\n\n"
end

# Establish SSH connection
exec "ssh root@#{host}"
