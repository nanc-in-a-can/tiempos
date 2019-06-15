

// mensajes OSC con gradiente de grises

// cortar textos

~string= "esto es una prueba para cortar y pegar textos";

~stringEditor= {|string|
	var size= string.size, first;
	first= [
		string[(rrand(0,10))..((size/[2,3,4,5].choose).round.asInteger)],
		string.split($ ).scramble.inject("scr:",_+_)[0..((size/[2,3,4,5].choose).round.asInteger)],
		string.split($ ).rotate(rrand(1,10)).inject("",_+_),
		string.replace("prueba", "TTTTTTTTTTT")

	].wchoose([1,2,3,1].normalizeSum);

	[first, first.replace("prueba", "TTTTTTTTTTT")].choose

};


~playSections = {|duraciones, ratio, string|
	Pbind(\dur, Pseq(duraciones*ratio,1),
	\string, Pfunc({~stringEditor.(string).postln}), \amp, 0,
	\MsgLinea1,
			Pfunc({|event| ~netAddr.sendMsg("/"++ratio.asSymbol, event[\string])})
	)
};









