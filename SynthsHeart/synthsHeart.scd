

(
var path, buffer;

path = thisProcess.nowExecutingPath.dirname++"/bassDrum.wav";

buffer = Buffer.read(s,path);

(
SynthDef(\bassHeart, { | amp=1, rate=1, out=0 |
	var sig, env, length;

	length= BufRateScale.ir(buffer.bufnum);
	sig= PlayBuf.ar(2,buffer.bufnum, rate);
	env= EnvGen.kr(Env([0,1,1,0],[0.001,1,0.01]),doneAction:2);

	Out.ar(out, sig*env*amp)
}).add
);



SynthDef(\crackle, {|in=8, out=99, gate=1|
	var sig, env;
	sig= Pan2.ar(Crackle.ar(TExpRand.kr(0.1,1.5, Dust.kr(13)))*In.ar(in), LFNoise2.ar(0.2));
	env= EnvGen.kr(Env.asr(0.0001,1,0.1),gate, doneAction:2);
	Out.ar(out, sig*env)
}).add;

SynthDef(\reverb, {|in=10, out=99, gate=1|
	var sig, env;
	sig= FreeVerb2.ar(In.ar(in), In.ar(in+1), 0.2, 0.3, 0.2);
	env= EnvGen.kr(Env.asr(0.0001,1,0.1),gate, doneAction:2);
	Out.ar(out, sig*env)
}).add;

SynthDef(\combC, {|in=12, out=99, gate=1|
	var sig, env;
	sig= Pan2.ar(CombC.ar(In.ar(in,2),1, LFNoise2.ar(0.05, 0.05, 0.06), 0.5, 0.35), LFNoise2.ar(0.2));
	env= EnvGen.kr(Env.asr(0.0001,1,0.1),gate, doneAction:2);
	Out.ar(out, sig*env)
}).add;

SynthDef(\convo, {|in=14, out=99, gate=1|
	var sig, env;
	sig= Pan2.ar(Convolution.ar(In.ar(in,2), WhiteNoise.ar(0.4), 512/8, 0.5).distort, LFNoise2.ar(0.2));
	env= EnvGen.kr(Env.asr(0.0001,1,0.1),gate, doneAction:2);
	Out.ar(out, sig*env*0.2)
}).add;

SynthDef(\verb, {|in=16, out=99, gate=1|
	var sig, env;
	sig= GVerb.ar(In.ar(in,2), 40, 10, 0.4, mul:0.25);
	env= EnvGen.kr(Env.asr(0.0001,1,0.1),gate, doneAction:2);
	Out.ar(out, sig*env)
}).add;

SynthDef(\vowel, {|in=18, out=99, gate=1, pan=0, vowel= 0|
	var sig, env;
	// bandpass filter con muchas bandas, filtra el input usando formantes de vocales,
	// la clase Vowel es la que genera las frecuencias donde ocurren los filtros tambien se decide la amplitud y el ancho de cada banda
	sig= BPFStack.ar(In.ar(in,2),Vowel([\a,\e,\i,\o,\u][0], [\bass, \tenor, \alto, \soprano]),1, 4, 1);
	sig= Pan2.ar(sig, pan)*4;
	env= EnvGen.kr(Env.asr(0.0001,1,0.1),gate, doneAction:2);
	Out.ar(out, sig*env)
}).add;


)


