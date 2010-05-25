Puppet::Type.newtype(:aptsourced) do
    @doc = "Manage apt-repo source files - one repo per file

    Example: 
        aptsourced { 'backports':
            uri          => 'http://www.backports.org/debian',
            distribution => $lsbdistcodename,
            components   => [ 'main', 'contrib' ],
        }

        aptsourced { 'internalrepo.list':
	          repotype     => 'deb-src'
            uri          => 'http://localhost/debian',
            distribution => $lsbdistcodename,
	          components   => [ 'main', 'nonfree' ],
	          ensure       => present   # optional
        }
    "

    ensurable do
       newvalue(:present) do
           provider.create
       end

       newvalue(:absent) do
           provider.destroy
       end

       # create if no ensure is present
       defaultto :present
    end


    newparam(:sourcename) do
        desc "The repos symbolic name (also used as the filename)"

        validate do | value |
            if value =~ /\//
                raise ArgumentError, "Repo sources must not contain /"
            end
        end

        # people seem to like using list as part of the name
        munge do |value|
            value.gsub!(/\.list$/, '') || value # must be a better way
        end

        isnamevar
    end


    newparam(:repotype) do
        desc "The repository type"

	defaultto "deb"

	validate do | value |
            unless value =~ /deb|deb-src/
	        raise ArgumentError, "repotype must be deb or deb-src"
            end
	end
    end


    newparam(:uri) do
        desc "The repos URI"

        validate do | value |
            if value.empty?
                raise ArgumentError, "A URI must be specified"
            end
        end
        # add real validation - better than URI#parse
    end


    newparam(:distribution) do
        desc "The distribution"

	validate do | value |
            unless value =~ /^\w+$/
	        raise ArgumentError, "Please supply a valid distribution name - e.g karmic or squeeze"
	    end
	end
    end


    newparam(:components) do
        desc "The components to use."

	validate do | value |
            if value.empty?
                raise ArgumentError, "Please supply at least one component - e.g main or nonfree"
            end
	end
	
	munge do |value|
            if value.is_a?(Array)
                value.join(" ")
            else
                value
            end
        end
    end
end
