//to make a rainball ball follow the mouse
import machine;
alias ball_=slowassign!(vec2,15);
alias rainbow=cycle![red,orange,yellow,green,blue,purple];
alias smoothrainbow=lerp!(rainbow,15);
alias ball=zip!(ball_,smoothrainbow,"color");

ball theball;
while(true){
	startdrawing();
		//drawcircle(vec2 where,color c,int size)
		drawcircle(theball,theball.color,30);
		theball+=mousepostion;
	enddrawing();
	theball++;
}

// to have the ball trailed by smaller ones
static foreach(i;[10,7,3,1]){
	drawcircle(theball[i],theball.color[i],i*3); //consider what happens if color has[i*2]
}