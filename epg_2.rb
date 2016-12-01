def decimal_zip(a, b)
	a = a.to_s.split("")
	b = b.to_s.split("")
	size = [a.length, b.length].max
	size = size.to_i
	result = String.new
	(0..(size - 1)).each do |x|
		result += a[x]
		result += b[x]
	end
	result.to_i
end