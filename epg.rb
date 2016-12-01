def get_k_whole_squares_between_two_n(a, b)
	k = 0
	(a..b).each do |i|
		k +=1 if Math.sqrt(i) % 1 == 0
	end
	k
end