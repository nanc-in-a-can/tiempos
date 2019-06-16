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
).add
)


