(
//Server.local.options.device = "MOTU Audio ASIO";
s.options.numOutputBusChannels = 8;
s.options.numBuffers = 1024 * 16;

s.waitForBoot({
    // osc info
    ~netAddr = NetAddr("127.0.0.1", 12000);

    // estas variables de control son útiles:
    ~start = "00:00:00"; // punto de inicio

    ~playTime = "00:10:00"; // duración de secuencia

    // variables necesarias:
    ~initialT = 0;
    ~lengthToPlay = 60*1;
    // ~initialT = (~start++":000").asSeconds;
    // ~lengthToPlay = (~playTime++":000").asSeconds;
    ~netAddr.sendMsg("/voice1", ".");
    ~netAddr.sendMsg("/timer1", "TIME");

    ~path = thisProcess.nowExecutingPath.dirname;
    [
        "/ensambles.scd",
        "/SynthClock/SynthTickTock.scd",
        "/SynthsHeart/synthsHeart.scd",
        "/recieveOSCHeart.scd",
        "/rhythms.scd",
        "/canoncitas.scd", // ~citasCan, ~durs, ~schedule, ~realschedule
        "/stringSuperCollider.scd", //~playSections
        "/clocks.scd"
    ].collect(~path++_).do(_.load);
})
)
s.boot
s.options.sampleRate = 48000
()
///////////
(
var ens = ~cuatroEnsambles.(~lista);
var inst = ~instrucciones.choose;
~mix = Synth(\compander, [\in, 99]);
~mix.set(\amp, 4);
Pdef(\ontoClock).play;
)
///////////


(
var ens = ~cuatroEnsambles.(~lista);
var inst = ~instrucciones.choose;
~mix.set(\amp, 0);
~netAddr.sendMsg("/ensamble0", ~join.(ens[0]));
~netAddr.sendMsg("/ensamble1", ~join.(ens[1]));
~netAddr.sendMsg("/ensamble2", ~join.(ens[2]));
~netAddr.sendMsg("/ensamble3", ~join.(ens[3]));
~netAddr.sendMsg("/instruccion0", inst);
~netAddr.sendMsg("/instruccion1", inst);
~netAddr.sendMsg("/instruccion2", inst);
~netAddr.sendMsg("/instruccion3", inst);
);
