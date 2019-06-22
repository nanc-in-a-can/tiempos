(
//load wavetable catalogue;
var path = thisProcess.nowExecutingPath.dirname;
~manecillas = SoundFile.collectIntoBuffers(path++"/tickTockSamples/*",s);
~manecillas= ~manecillas.collect({|item,iter| item.bufnum});

SynthDef(\clock, { |freq, amp, out, bufnum|
	var sig, env;

	sig= PlayBuf.ar(2, bufnum, 1*freq.midiratio);
	env= EnvGen.kr(Env([0,1,1,0],[0.0001,0.5,0.0001]),doneAction:2);

	Out.ar(out, sig*env)
}
).add;

SynthDef(\compander, {|in=99, out=0, gate=1, pan= 0, amp=1|
	var sig, env;
	sig= Pan2.ar(Compander.ar(In.ar(in,2), WhiteNoise.ar(0.99), 0.75, mul:0.9), pan);
	env= EnvGen.kr(Env.adsr(0.0001,1,0.1),gate, doneAction:0);
	Out.ar(out, sig*env*amp)
}).add;


)


