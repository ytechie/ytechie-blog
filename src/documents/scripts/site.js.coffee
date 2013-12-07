htmlEncode = (value) ->
	$('<div/>').text(value).html()
$ ->
	$('.post img').each ->
		$el = $(this)
		$el.addClass('img-responsive')

	$('img').each ->
		el = $(this)
		re = /.*@2x\..+/
		if re.test(el.attr('src'))
			h = el.height()
			w = el.width()
			el.height(h/2.0)
			el.width(w/2.0)


	$('pre code').each (index, element) ->
		$code = $(this)
		classes = $code.attr('class')?.split(' ')
		if classes? then for origClass in classes
			fixedClass = origClass.replace /^lang-/, 'language-'
			$code.removeClass(origClass).addClass(fixedClass) if fixedClass isnt origClass
		try
			hljs.highlightBlock(element)
		catch e
			# absorb any problems, usually with older browsers