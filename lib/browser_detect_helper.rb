module BrowserDetectHelper

	def browser_is? name
		name = name.to_s.strip
		return true if browser_name == name
		return true if name == 'mozilla' && browser_name == 'gecko'
		return true if name == 'ie' && browser_name.index('ie')
		return true if name == 'webkit' && %w{safari chrome iphone ipad ipod}.include?(browser_name)
	end

	def browser_name
		@browser_name ||= begin
			if ua.index('msie') && !ua.index('opera') && !ua.index('webtv')
				'ie'+ua[ua.index('msie')+5].chr
			elsif ua.index('gecko/')
				'gecko'
			elsif ua.index('opera')
				'opera'
			elsif ua.index('konqueror')
				'konqueror'
			elsif ua.index('ipod')
				'ipod'
			elsif ua.index('ipad')
				'ipad'
			elsif ua.index('iphone')
				'iphone'
			elsif ua.index('chrome/')
				'chrome'
			elsif ua.index('applewebkit/')
				'safari'
			elsif ua.index('mozilla/')
				'gecko'
			end

		end
	end
	
	def browser_webkit_version
		if browser_is? 'webkit'
			match = ua.match(%r{\bapplewebkit/([\d\.]+)\b})
			if (match)
				match[1].to_f
			else
				nil
			end
		else
			nil
		end
	end
	
	def ua
		@ua ||= request.env['HTTP_USER_AGENT'].downcase
	end

end
