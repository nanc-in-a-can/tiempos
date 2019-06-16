
// receiving the msg from processing.....
//OSCFunc.trace(true); // Turn posting on
//OSCFunc.trace(false); // Turn posting off

// esto prende el monitor de ritmo cardiaco
/*
~verb= Synth(\verb, [\in, 10, \out, 0]);
~corazon= ~startHeart.()

~netAddr.sendMsg("/heart", 700);

(
// esto apaga el monitor de ritmo cardiaco
~corazon.free;
~netAddr.sendMsg("/heart", 0);
);
*/

(
// funciones necesarias
(
~startHeart= {
	var oldNum= 0.5;
	var num= 0;

	o = OSCdef(\cora, { |msg, time, addr, recvPort| //[msg, time, addr, recvPort].postln;
		num= msg[1].linlin(0, 512*2, 0.00, 1.00);
		~heartBeat.(num, oldNum, 0.675);
		oldNum= num;

	},
	'/heart', n, 12000)
};

o // regresa el oscdef para poder apagarlo desde afuera

);



(
~heartBeat= {|numero, numViejo, threshold|

		if( numero>=threshold,
			{
				if(numViejo>numero, {"GOT IT".postln;

				Synth(\bassHeart, [\out, [10,0]]);


			});




			},
			{"below threshold".postln} );
		("oldNum now is"+numViejo.asString+"and num is"+numero.asString).postln;


	};
)
);


