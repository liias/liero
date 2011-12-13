{$m 65521,0,655360}

{$g+ X+ F+ O+}
program mato2;

uses area,crt,keyboard,grap;

const
	syncon:boolean=true;
	version='0.25';
	speed=18;
{	numsounds=30;}
{	XMSRequired   = 471754 div 1024;    {XMS memory required to load the sounds (KBytes) }
	{SharedEMB     = true;}
	mtippu=1000;
	tippu=350;
	width=568;
	height=350;
	wi=width-1;
	he=height-1;
	heg=height-3;
	{mapsizex=44;
	mapsizey=40;
	{mapx=159-mapsizex shr 1;
	mapy=199-mapsizey;
	mapmulx=(wd) div mapsizex;
	mapmuly=(hg) div mapsizey;}
	tyhjaa=10;
	kivia=30;
	isoja=12;
	montteja=80;
	luita=20;
	g1s=180;
	fon=27;
	suuliegispd=4;
	respawntime=100;
	enupic=55;
	ammpic=57;
	relpic=17;
	plspic=81;
	ipos:array[0..1,0..1]of integer=((0,0),(160,0));
	epos:array[0..1]of integer=(0,218);
	mpos:array[0..1,boolean]of byte=((20,24),(28,32));
	liikpos:array[0..1,boolean]of byte=((111,115),(119,123));
	wpos:array[0..1]of integer=(30,190);
	plrs:array[0..1]of set of byte=([30..38],[39..47]);
	pchn:array[0..1]of byte=(19,20);
	mcol:array[0..1]of byte=(32,41);
	mliv:array[0..1]of byte=(39,59);
	kivet:array[0..2,0..3]of byte=
		((16,60,61,62),(63,75,85,86),(89,90,54,128));
	dieblood:integer=15;
	diefrags=10;
	maxen=100;
	mdivd=maxen shr 4;
	maxblts=300;
	maxexpls=200;
	maxblood=300;
	maxfrags=500;
 {maxexpfs=200;}
	mspeed=2900;
	maxspd=$7000;
	hyppy=38000;
	mresist=90;
	bdirp=15000;
	dvd=100;
	divd=$10000;
	turnspeed=26000;
	startlives:byte=15;
	loppuaika=256;
	eqspeed=7000;
	{ores=127;
	odiv=128;}

	frags=11;
	{fchknum:array[1..frags]of byte=(234,157,61,131,16,212,23);}
	{fsound:array[1..frags]of byte=(0,0,0,0,0,0,0,{24}{0,0,0,0);}
	fspeed:array[1..frags]of integer=(120,120,80,160,190,220,100,0,180,130,40);
	fgrav:array[1..frags]of integer=(600,600,400,480,480,480,480,600,480,500,
		300);
	fspdh:array[1..frags]of integer=(90,90,50,120,140,160,70,0,110,80,30);
	fdirp:array[1..frags]of integer=(0,0,20000,20000,20000,0,12000,0,20000,
		20000,10000);
	fmove:array[1..frags]of byte=(0,0,0,10,10,15,0,0,0,0,0);
	{fresist:array[1..frags]of integer=(96,96,97,96,96,98,98);}
	fboing:array[1..frags]of byte=(0,0,0,0,0,0,0,40,0,60,10);
	fpower:array[1..frags]of byte=(0,0,0,2,3,4,0,0,1,0,1);
	fboom:array[1..frags]of byte=(0,0,0,0,0,0,0,0,1,0,0);
	fhit:array[1..frags]of byte=(0,0,0,1,1,1,0,0,1,0,0);
	fblood:array[1..frags]of byte=(0,0,0,2,2,2,0,0,0,0,0);
	fpic:array[1..frags]of byte=(157,161,0,0,0,0,0,147,139,171,177);
	fpics:array[1..frags]of byte=(3,3,0,0,0,0,0,3,3,0,3);
	fdpic:array[1..frags]of byte=(1,1,0,0,0,0,0,1,0,0,0);
	fcol:array[1..frags]of byte=(0,0,17,67,67,67,82,0,0,0,0);
	fexpl:array[1..frags]of byte=(0,0,0,3,3,3,0,0,2,1,0);
	fexpvaik:array[1..frags]of byte=(0,0,0,0,0,0,0,0,1,1,0);
	fhole:array[1..frags]of byte=(0,0,0,3,3,3,0,0,2,3,0);
	ffrags:array[1..frags]of byte=(0,0,0,0,0,0,0,0,3,3,0);
	fftype:array[1..frags]of byte=(0,0,0,0,0,0,0,0,5,6,0);
	ftbld:array[1..frags]of byte=(1,1,0,0,0,0,1,0,0,0,0);
	fbdelay:array[1..frags]of byte=(9,9,0,0,0,0,9,0,0,0,0);
	fpera:array[1..frags]of byte=(0,0,0,0,0,0,0,0,0,6,0);
	fpdelay:array[1..frags]of byte=(0,0,0,0,0,0,0,0,0,6,0);
	frange:array[1..frags]of integer=(0,0,0,0,0,0,0,0,0,180,400);
	frangeh:array[1..frags]of byte=(0,0,0,0,0,0,0,0,0,80,200);
	frandom:array[1..frags]of byte=(0,0,0,0,0,0,0,0,0,0,4);

	carry=5;
	guns=23;
	{gchknum:array[1..guns]of byte=(49,5,78,12,54,236,125,92,97,19,165,224,26);}
	gname:array[1..guns]of string[13]=('SHOTGUN','CHAINGUN','RIFLE','BAZOOKA',
	'DIRTBALL','EXPLOSIVES','MINE','WINCHESTER','DOOMSDAY','FLAMER','GRENADE',
	'LARPA','BLASTER','BOUNCY MINE','MINIGUN','CLUSTER BOMB','REMOTE BOMB',
	'AUTO PISTOL','GREENBALL','BIG NUKE','CRACKLER','ZIMM','FLAME BOMB');
	{gsound:array[1..guns]of byte=(1,2,3,4,5,6,6,3,7,0,6,7,5,6,2,6,6,2,0,6,6,7,
		6);
	gsloop:array[1..guns]of byte=(0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,
		0);
	gesound:array[1..guns]of byte=(0,0,0,0,14,0,0,0,0,0,0,0,0,0,0,0,0,0,14,5,
		0,0,7);}
	gspeed:array[1..guns]of integer=(210,210,340,230,200,150,90,280,120,100,
		110,220,130,100,260,110,60,160,200,170,170,300,85);
	gdirp:array[1..guns]of integer=(10000,4000,0,0,12000,16000,8000,100,
		6000,10000,7000,0,0,8000,16000,7000,8000,2000,23000,25000,32000,0,7000);
	gnum:array[1..guns]of byte=(12,1,1,1,1,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1);
	gpotku:array[1..guns]of byte=(55,6,100,45,0,0,0,35,15,0,0,20,30,0,6,0,1,20,
		10,0,0,30,0);
	gmove:array[1..guns]of byte=(10,10,30,0,0,0,60,30,15,0,0,40,30,22,10,0,0,20,
		0,0,0,0,0);
	{gresist:array[1..guns]of integer=(100,100,100,100,100,100,100,100,100,100,
	100,100,100,100,100);}
	gload:array[1..guns]of integer=(45,3,0,85,20,0,0,35,11,2,0,60,70,0,0,0,0,20,
		4,0,0,70,0);
	gclipload:array[1..guns]of integer=(250,250,320,450,250,100,250,250,550,250,
		250,350,250,350,550,550,320,120,250,600,500,500,350);
	gclip:array[1..guns]of byte=(7,50,1,3,5,1,1,12,12,100,1,3,3,1,70,1,1,15,40,
		1,1,2,1);
	gexpl:array[1..guns]of byte=(3,3,3,1,0,1,2,3,2,0,1,2,1,2,3,1,1,3,0,0,2,5,0);
	ghole:array[1..guns]of byte=(3,3,3,1,5,1,2,3,2,6,1,2,1,2,3,1,1,3,7,0,2,0,0);
	gshellt:array[1..guns]of byte=(1,2,1,0,0,0,0,1,0,0,0,0,0,0,2,0,0,1,0,0,0,0,
		0);
  gshellr:array[1..guns]of byte=(24,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1);
	{grlsound:array[1..guns]of byte=(1,1,1,1,1,0,0,1,1,0,0,1,1,0,1,0,0,1,1,0,1,
		1,1);}
	gboom:array[1..guns]of byte=(0,0,0,1,1,1,1,0,0,0,0,0,0,1,0,0,1,1,1,0,0,1,1);
	gheti:array[1..guns]of byte=(1,1,1,1,0,0,0,1,1,1,0,1,1,0,1,0,0,1,1,0,0,0,0);
	ghit:array[1..guns]of byte=(1,1,1,1,0,0,1,1,1,1,0,1,1,1,1,0,0,1,1,0,0,1,0);
	gfire:array[1..guns]of byte=(1,1,1,1,0,0,0,1,1,0,0,1,1,0,1,0,0,1,0,0,1,0,0);
	ggrav:array[1..guns]of integer=(600,600,20,100,800,700,800,20,100,-600,
		800,180,700,700,600,800,600,600,700,900,400,0,700);
	{ghoming:array[1..guns]of byte=(0,0,0,0,0,0,0,0,70,0,0,0,0,0,0,0,0);}
	gexpvaik:array[1..guns]of byte=(0,0,0,0,1,1,1,0,0,0,1,0,0,1,0,1,1,0,1,1,1,
		0,1);
	gboing:array[1..guns]of byte=(0,0,0,0,30,30,40,0,0,0,40,0,0,100,0,50,30,0,
		0,50,40,100,30);
	grange:array[1..guns]of integer=(0,0,0,0,80,50,10000,0,0,40,150,0,0,8000,0,
		160,10000,0,0,170,500,1000,140);
	grangeh:array[1..guns]of integer=(0,0,0,0,20,6,600,0,0,5,10,0,0,800,0,15,0,
		0,0,20,100,300,10);
	gpower:array[1..guns]of byte=(2,2,40,30,0,0,12,14,12,2,0,10,8,15,2,0,0,5,
		0,0,0,49,0);
	gblood:array[1..guns]of byte=(1,1,5,20,0,0,10,4,8,0,0,3,8,12,1,0,0,2,0,0,0,
		0,0);
	gpic:array[1..guns]of byte=(0,0,0,64,73,135,165,0,95,151,143,104,71,81,0,
		143,52,0,0,84,102,134,176);
	gpics:array[1..guns]of byte=(0,0,0,0,0,3,3,0,0,5,3,0,0,2,0,3,0,0,0,0,0,0,0);
	grandomp:array[1..guns]of byte=(0,0,0,0,0,1,0,0,0,0,1,0,0,1,0,1,0,0,0,0,0,
		0,0);
	gdirec:array[1..guns]of byte=(0,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,
		0);
	gcol:array[1..guns]of byte=(68,68,68,0,0,0,0,68,0,0,0,0,0,0,68,0,0,68,135,
		0,0,0,0);
	gfrags:array[1..guns]of byte=(0,0,4,12,0,0,5,3,0,0,45,5,40,7,0,18,40,0,0,
		38,4,0,40);
	gftype:array[1..guns]of byte=(3,3,4,5,0,3,4,4,3,0,6,4,5,4,3,9,5,0,0,10,5,0,
		11);
	gpera:array[1..guns]of byte=(0,0,0,4,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0);
	gptimer:array[1..guns]of byte=(0,0,0,6,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,
		0);
	gfp12:array[1..guns]of byte=(0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0);
	gfpera:array[1..guns]of byte=(0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,4,0,
		0);
	gfptimer:array[1..guns]of byte=(0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,8,
		0,0);
	gfto:array[1..guns]of byte=(1,1,0,1,0,1,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0);
	gbldl:array[1..guns]of byte=(0,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0);

	holes=7;
	hpic:array[1..holes]of byte=(0,1,2,74,0,103,72);
	hfrom:array[1..holes]of byte=(87,87,87,87,169,87,37);
	hfroms:array[1..holes]of byte=(2,2,2,2,2,2,2);
	hto:array[1..holes]of byte=(1,1,1,1,0,1,0);

	exps=6;
	{esound:array[1..exps]of byte=(10,10,8,0,0,0);
	esounds:array[1..exps]of byte=(4,4,2,0,0,0);}
	{echknum:array[1..exps]of byte=(67,91,162,14,73);}
	espeed:array[1..exps]of byte=(5,5,4,4,5,3);
	epics:array[1..exps]of byte=(40,45,49,76,129,172);
	erange:array[1..exps]of byte=(16,12,8,0,0,0);
	epower:array[1..exps]of byte=(15,10,5,0,0,0);
	emove:array[1..exps]of longint=(4000,5000,6000,0,0,0);
	elen:array[1..exps]of byte=(4,3,2,4,5,3);
	evaik:array[1..exps]of byte=(1,1,1,0,0,0);
	equake:array[1..exps]of byte=(4,2,1,0,0,0);
	eflash:array[1..exps]of byte=(30,0,0,0,0,0);
	{efls:array[1..exps]of byte=(20,10,5,0,0);}

	sand:set of byte=[1,16..19,55..58,69..71,82..84,88..90,98..103,120..122];
	mud:set of byte=[2,94..97];
	stone:set of byte=[24..29,59..61,85..87,91..93,123..125];
	vapaa:set of byte=[1,2,20..23];
	flashlen=4;
	k:array[0..1,0..6]of byte=(
	(kbr,kbf,kbd,kbg,kblctrl,kblshift,kblalt),
	(kbup,kbdown,kbleft,kbright,kbrctrl,kbralt,kbrshift)
	);
	cycles=2;
	cycle:array[1..cycles,0..1]of byte=((129,132),(133,136));
	mkmode:boolean=false;
	pls:array[0..1]of byte=(1,0);

type
{  st12=string[12];}
	fixed=record case boolean of
		true:(l:longint);
		false:(w:word;i:integer);
	end;
	harpoon=record
		k:boolean;
		x,y:fixed;
		xb,yb:longint;
	end;
	mies=record
		x,y:fixed;
		h:harpoon;
		xb,yb,lives:longint;
		stimer,sht,gtimer,ctimer,rtimer,g,energy:integer;
		a:fixed;
		guns:array[1..carry]of word;
		clips:array[1..carry]of integer;
		shoot,loaded,showg,alive,jump,dir,harp,mov,phar,dig,rem:boolean;
		change:array[0..1]of boolean;
	end;
	bullet=record
		x,y:fixed;
		xb,yb:longint;
		t:byte;
		a:shortint;
		r:longint;
	end;
	explosion=record
		jo:array[0..1]of boolean;
		x,y:integer;
		t:byte;
		p:shortint;
		timer:integer;
	end;
	blood=record
		t:boolean;
		x,y:fixed;
		xb,yb:longint;
	end;
	fragment=record
		x,y:fixed;
		xb,yb,r:longint;
		t,p:byte;
	end;
	explosf=record
		x,y:fixed;
		xb,yb:longint;
		c:byte;
	end;
	pic16=array[0..15,0..15]of byte;
	pic8=array[0..7,0..7]of byte;
	font=array[0..3,0..3]of byte;
	gfx16=array[0..g1s]of pic16;
	fonts=array[0..fon]of font;
	bullets=array[0..maxblts]of ^bullet;
	expls=array[0..maxexpls]of ^explosion;
	bloods=array[0..maxblood]of ^blood;
	fragments=array[0..maxfrags]of ^fragment;
{	harpoons=array[0..1,0..maxharps]of harpoon;}
	fonts8=array[0..249]of pic8;
{	expfs=array[0..maxexpfs]of explosf;}
  tnames=array[0..1]of string[80];
	madot=array[0..1]of mies;

const
	frgsz=sizeof(fragment);
	bldsz=sizeof(blood);
	bltsz=sizeof(bullet);
	expsz=sizeof(explosion);

var
	este:set of byte;
	hajo:set of byte;
	alue:set of byte;
	time:longint absolute $0:$46c;
	vga:tscreen absolute $a000:0;
	m:^madot;
	arena:parea;
	playpal,flpal:^palette;
	g1:^gfx16;
	f:^fonts;
	tab:array[0..64,0..1]of longint;
	v:screen;
	blt:^bullets;
{  bo:array[0..maxblts]of byte;}
	exp:^expls;
	bld:^bloods;
	frg:^fragments;
{	hrp:^harpoons;}
	f8:^fonts8;
{	efs:^expfs;}
	nx,ny:array[0..1]of integer;
	tnx,tny:array[0..1]of integer;
	frames:word;
	rl,flashb:boolean;
	flash,loppu,quake:integer;
	hs:pointer;
	eq:array[0..1]of fixed;
	flbr:byte;
  died:array[0..1]of string[84];
	dtimer:array[0..1]of shortint;
	names:^tnames;
{	map:array[0..mapsizey-1,0..mapsizex-1]of byte;}

{	BaseIO: word; IRQ, DMA, DMA16: byte;
	Sound: array[1..NumSounds] of PSound;
	{ssize:array[1..numsounds]of word;}

function tostr(l:longint):string;
var s:string;
begin
	str(l,s);
	tostr:=s;
end;

procedure pica(x,y:integer;var source1,source2;t:boolean);
var xp,yp,xl,yl:integer;
	s1:pic16 absolute source1;
	s2:pic16 absolute source2;
begin
	if t then begin
	for xl:=0 to 15 do begin
		xp:=xl+x;
		for yl:=0 to 15 do begin
			yp:=yl+y;
			case s1[yl,xl]of
				6:if(xp>-1)and(xp<width)and(yp>-1)and(yp<he)and
					(arena^[yp]^[xp]in hajo)then
						arena^[yp]^[xp]:=s2[yp and 15,xp and 15];
				1:if(xp>-1)and(xp<width)and(yp>-1)and(yp<he)then begin
					if(arena^[yp]^[xp]in sand)then
						arena^[yp]^[xp]:=1;
					if(arena^[yp]^[xp]in mud)then
						arena^[yp]^[xp]:=2;
				end;
			end;
		end;
	end;
	end else begin
	for xl:=0 to 15 do begin
		xp:=xl+x;
		for yl:=0 to 15 do begin
			yp:=yl+y;
			case s1[yl,xl]of
				10,6:if(xp>-1)and(xp<width)and(yp>-1)and(yp<he)and
					(arena^[yp]^[xp]in vapaa)then
						arena^[yp]^[xp]:=s2[yp and 15,xp and 15];
				2:if(xp>-1)and(xp<width)and(yp>-1)and(yp<he)and
					(arena^[yp]^[xp]in vapaa)then
						arena^[yp]^[xp]:=2;
				1:if(xp>-1)and(xp<width)and(yp>-1)and(yp<he)and
					(arena^[yp]^[xp]in vapaa)then
						arena^[yp]^[xp]:=1;
			end;
		end;
	end;
	end;
end;

procedure picb(x,y:integer;var source);
var xp,yp,xl,yl:integer;
	s:pic16 absolute source;
begin
	for xl:=0 to 15 do begin
		xp:=xl+x;
		for yl:=0 to 15 do begin
			yp:=yl+y;
			if s[yl,xl]or 0>0 then
				if(xp>-1)and(xp<width)and(yp>-1)and(yp<height)then
					if(arena^[yp]^[xp]in alue)then
						arena^[yp]^[xp]:=s[yl,xl]else
						arena^[yp]^[xp]:=s[yl,xl]+3;
		end;
	end;
end;

function testk(x,y,s:integer):boolean;
var xx,yy:integer;
begin
	testk:=false;
	for xx:=x to x+s do for yy:=y to y+s do
		if arena^[yy]^[xx]in stone then exit;
	testk:=true;
end;

procedure fillarea;
var aa,a,b,c,d,x,y:integer;
begin
	for a:=0 to height-1 do for b:=0 to width-1 do
		arena^[a]^[b]:=random(4)+16;
	for a:=1 to montteja do begin
		b:=random(width)-8;
		c:=random(height)-8;
		for aa:=0 to random(7) do begin
			inc(b,-32+random(64));
			inc(c,-32+random(64));
			d:=91+random(4);
			picb(b,c,g1^[d])
		end;
	end;
	for a:=1 to tyhjaa do begin
		b:=random(width)-8;
		c:=random(height)-8;
		for aa:=0 to random(20) do begin
			inc(b,-8+random(16));
			inc(c,-8+random(16));
			{for y:=0 to 15 do for x:=0 to 15 do
			if(g1^[d,y,x]>0)and(b+x>-1)and(b+x<width)and
				(c+y>-1)and(c+y<height) then arena^[y+c]^[x+b]:=g1^[d,y,x];}
			pica(b,c,g1^[hpic[1]],g1^[hfrom[1]+random(hfroms[1])],true);
		end;
	end;
	for a:=1 to luita do begin
		b:=random(width)-8;
		c:=random(height)-8;
		d:=55+random(4);
		picb(b,c,g1^[d])
	end;
	for a:=1 to isoja do begin
		repeat
		b:=random(width)-16;
		c:=random(height)-16;
		until testk(b,c,32);
		d:=random(3);
		picb(b,c,g1^[kivet[d,0]]);
		picb(b+16,c,g1^[kivet[d,1]]);
		picb(b,c+16,g1^[kivet[d,2]]);
		picb(b+16,c+16,g1^[kivet[d,3]]);
	end;
	for a:=1 to kivia do begin
		repeat
		b:=random(width)-8;
		c:=random(height)-8;
		until testk(b,c,15);
		{for aa:=0 to random(4) do begin
			inc(b,-40+random(80));
			inc(c,-40+random(80));}
			d:=3+random(6);
			picb(b,c,g1^[d])
		{end;}
	end;
end;

{function HexW(W: word): string;
const
	HexChars: array [0..$F] of Char = '0123456789ABCDEF';
begin
	HexW :=
	HexChars[(W and $F000) shr 12] +
	HexChars[(W and $0F00) shr 8]  +
	HexChars[(W and $00F0) shr 4]  +
	HexChars[(W and $000F)];
end;}


procedure newfrg1(t:byte;x,y:integer;xb,yb:longint);
var i:integer;
begin
{	if chknum[t]=fchknum[t] then begin}
	if maxavail<frgsz then exit;
		i:=0;
		while(frg^[i]<>nil)and(i<maxfrags)do inc(i);
		new(frg^[i]);
		frg^[i]^.t:=t;
		frg^[i]^.x.i:=x-7;
		frg^[i]^.y.i:=y-7;
		frg^[i]^.xb:=xb;
		frg^[i]^.yb:=yb;
		inc(frg^[i]^.x.l,frg^[i]^.xb);
		inc(frg^[i]^.y.l,frg^[i]^.yb);
		if fpic[t]>0 then frg^[i]^.p:=random(fpics[t]+1)
		else frg^[i]^.p:=fcol[t];
			frg^[i]^.r:=frange[t]-random(frangeh[t]);
end;

procedure newfrg2(t,c:byte;x,y:integer;xb,yb:longint;a:shortint);
var i,s:integer;
	xx,yy:fixed;
begin
{	if chknum[t]=fchknum[t] then begin}
	if maxavail<frgsz then exit;
		i:=0;
		while(frg^[i]<>nil)and(i<maxfrags)do inc(i);
		new(frg^[i]);
		frg^[i]^.t:=t;
		frg^[i]^.x.i:=x-7;
		frg^[i]^.y.i:=y-7;
		s:=fspeed[t]-random(fspdh[t]);
		frg^[i]^.xb:=xb+(s*tab[a,0]div dvd)-fdirp[t]+random(fdirp[t] shl 1);
		frg^[i]^.yb:=yb+(s*tab[a,1]div dvd)-fdirp[t]+random(fdirp[t] shl 1);
		inc(frg^[i]^.x.l,frg^[i]^.xb);
		inc(frg^[i]^.y.l,frg^[i]^.yb);
		if fpic[t]>0 then frg^[i]^.p:=random(fpics[t]+1)
		else begin
			if c=0 then frg^[i]^.p:=fcol[t] else frg^[i]^.p:=c;
		end;
      frg^[i]^.r:=frange[t]-random(frangeh[t]);
end;

procedure newblt(t,pl:byte;x,y:longint;a:shortint);
var i,p:integer;
{const
	chknum:array[1..guns]of byte=(49,5,78,12,54,236,125,92,97,19,165,224,26);}
begin
{	if chknum[t]=gchknum[t] then begin}
	if maxavail<bltsz then exit;
		i:=0;
		while(blt^[i]<>nil)and(i<maxblts)do inc(i);
		new(blt^[i]);
		blt^[i]^.t:=t;
		blt^[i]^.x.l:=x;
		blt^[i]^.y.l:=y;
		blt^[i]^.xb:=(gspeed[t]*tab[a,0]div dvd)-
			gdirp[t]+random(gdirp[t]shl 1);
		blt^[i]^.yb:=(gspeed[t]*tab[a,1]div dvd)-
			gdirp[t]+random(gdirp[t]shl 1);
		if gdirec[t]and 1=1 then begin
			p:=a-5;
			if p<0 then inc(p,64);
			p:=p shr 3;
			blt^[i]^.a:=p;
		end else if(grange[t]>0)and(grangeh[t]=0)then begin
			blt^[i]^.a:=pl;
		end else begin
			if grandomp[t]and 1=1 then blt^[i]^.a:=random(gpics[t]+1)
			else blt^[i]^.a:=0;
		end;
		{if 0=ghoming[t] then }blt^[i]^.r:=grange[t]-random(grangeh[t])
		{else if pl=0 then blt^[i]^.r:=1 else blt^[i]^.r:=0;}
end;

{procedure newef(x,y:integer);
var i:integer;
begin
	i:=0;
	while(efs^[i].c>0)and(i<maxexpfs)do inc(i);
	efs^[i].x.i:=x;
	efs^[i].y.i:=y;
	efs^[i].xb:=-32000+random(64000);
	efs^[i].yb:=-32000+random(64000);
	efs^[i].c:=119;
end;}

procedure newexp(t:byte;x,y:integer);
{const chknum:array[1..exps]of byte=(67,91,162,14,73);}
var i:integer;
	xx,yy,xi,yi:integer;
begin
{	if(chknum[t]=echknum[t])and(t<=exps) then begin
{		for i:=1 to efls[t]do newef(x,y);}
	if maxavail<expsz then exit;
		i:=0;
		while(exp^[i]<>nil)and(i<maxexpls)do inc(i);
		new(exp^[i]);
		{if esound[t]>0 then
			startsound(sound[esound[t]+random(esounds[t])],esound[t],false);}
		if(x>nx[0])and(x<nx[0]+viewx)and
			(y>ny[0])and(y<ny[0]+viewy)then
			if eq[0].i<equake[t] then eq[0].i:=equake[t];
		if(x>nx[1])and(x<nx[1]+viewx)and
			(y>ny[1])and(y<ny[1]+viewy)then
			if eq[1].i<equake[t] then eq[1].i:=equake[t];
		exp^[i]^.t:=t;
		exp^[i]^.x:=x-7;
		exp^[i]^.y:=y-7;
		exp^[i]^.jo[0]:=evaik[t]and 1=1;
		exp^[i]^.jo[1]:=evaik[t]and 1=1;
		exp^[i]^.p:=0;
		exp^[i]^.timer:=espeed[t];
		if eflash[t]>0 then begin
			flashb:=true;
			flash:=flashlen;
			flbr:=eflash[t];
		end;
		i:=erange[t]shr 1;
		for xx:=-i to i do begin
			xi:=xx+x;
			for yy:=-i to i do begin
				yi:=yy+y;
				if arena^[yi]^[xi]in hajo then if random(5)=0 then
					newfrg2(3,arena^[yi]^[xi],xi,yi,0,0,random(64));
			end;
		end;
end;

procedure newbld(x,y:integer;xb,yb:longint);
var i:integer;
begin
	if maxavail<bldsz then exit;
	i:=0;
	while(bld^[i]<>nil)and(i<maxblood)do inc(i);
	new(bld^[i]);
	bld^[i]^.t:=true;
	bld^[i]^.x.i:=x;
	bld^[i]^.y.i:=y;
	bld^[i]^.xb:=xb;
	bld^[i]^.yb:=yb;
end;

procedure line1(x1,y1,x2,y2:integer);
const
	cx1=0;
	cx2=viewx-1;
	cy1=0;
	cy2=viewy-1;
function sign(x:integer):integer; {like sgn(x) in basic}
begin if x<0 then sign:=-1 else if x>0 then sign:=1 else sign:=0 end;
var
	x,y,count,xs,ys,xm,ym:integer;
	col:byte;
begin
	col:=62;
	x:=x1;y:=y1;xs:=x2-x1;ys:=y2-y1;xm:=sign(xs);
	ym:=sign(ys);xs:=abs(xs);ys:=abs(ys);
	if(x>=cx1)and(x<=cx2)and(y>=cy1)and(y<=cy2)then v^[y,x]:=col;
	if xs > ys then begin {flat line <45 deg}
		count:=-(xs div 2);
		while (x <> x2 ) do begin
			count:=count+ys;
			x:=x+xm;
			if count>0 then begin
				y:=y+ym;
				count:=count-xs;
				end;
			if(x>=cx1)and(x<=cx2)and(y>=cy1)and(y<=cy2)then begin
				inc(col);
				if col=64 then col:=62;
				v^[y,x]:=col;
			end;
			end;
		end
	else begin {steep line >=45 deg}
		count:=-(ys div 2);
		while (y <> y2 ) do begin
			count:=count+xs;
			y:=y+ym;
			if count>0 then begin
				x:=x+xm;
				count:=count-ys;
				end;
			if(x>=cx1)and(x<=cx2)and(y>=cy1)and(y<=cy2)then begin
				inc(col);
				if col=64 then col:=62;
				v^[y,x]:=col;
			end;
			end;
		end;
end;
procedure line2(x1,y1,x2,y2:integer);
const
	cx1=160;
	cx2=160+viewx-1;
	cy1=0;
	cy2=viewy-1;
function sign(x:integer):integer; {like sgn(x) in basic}
begin if x<0 then sign:=-1 else if x>0 then sign:=1 else sign:=0 end;
var
	x,y,count,xs,ys,xm,ym:integer;
	col:byte;
begin
	col:=62;
	x:=x1;y:=y1;xs:=x2-x1;ys:=y2-y1;xm:=sign(xs);
	ym:=sign(ys);xs:=abs(xs);ys:=abs(ys);
	if(x>=cx1)and(x<=cx2)and(y>=cy1)and(y<=cy2)then v^[y,x]:=col;
	if xs > ys then begin {flat line <45 deg}
		count:=-(xs div 2);
		while (x <> x2 ) do begin
			count:=count+ys;
			x:=x+xm;
			if count>0 then begin
				y:=y+ym;
				count:=count-xs;
				end;
			if(x>=cx1)and(x<=cx2)and(y>=cy1)and(y<=cy2)then begin
				inc(col);
				if col=64 then col:=62;
				v^[y,x]:=col;
			end;
			end;
		end
	else begin {steep line >=45 deg}
		count:=-(ys div 2);
		while (y <> y2 ) do begin
			count:=count+xs;
			y:=y+ym;
			if count>0 then begin
				x:=x+xm;
				count:=count-ys;
				end;
			if(x>=cx1)and(x<=cx2)and(y>=cy1)and(y<=cy2)then begin
				inc(col);
				if col=64 then col:=62;
				v^[y,x]:=col;
			end;
			end;
		end;
end;


procedure pico1(x,y:integer;var source);
const
	cx1=0;
	cx2=viewx-1;
	cy1=0;
	cy2=viewy-1;
var xx,yy:integer;
	f:font absolute source;
begin
	for yy:=0 to 3 do begin
		if y>cy2 then exit;
		if y>=cy1 then begin
		for xx:=0 to 3 do begin
			if (x>=cx1)and(x<=cx2)and(f[yy,xx]or 0>0) then v^[y,x]:=f[yy,xx];
			inc(x);
		end;
		dec(x,4);
		end;
		inc(y);
	end;
end;
procedure pico2(x,y:integer;var source);
const
	cx1=160;
	cx2=160+viewx-1;
	cy1=0;
	cy2=viewy-1;
var xx,yy:integer;
	f:font absolute source;
begin
	for yy:=0 to 3 do begin
		if y>cy2 then exit;
		if y>=cy1 then begin
		for xx:=0 to 3 do begin
			if (x>=cx1)and(x<=cx2)and(f[yy,xx]or 0>0) then v^[y,x]:=f[yy,xx];
			inc(x);
		end;
		dec(x,4);
		end;
		inc(y);
	end;
end;

function test(x,y,vx,vy,mx,my:integer):boolean;
var xx,yy,xi,yi:integer;
begin
	xx:=x-vx;
	yy:=y-vy;
	xi:=x-mx;
	yi:=y-my;
	test:=true;
	if((abs(xx)>viewx)or(abs(yy)>viewy))and
		((abs(xi)>viewx)or(abs(yi)>viewy))then begin
	for xx:=x-1 to x+1 do for yy:=y-2 to y+4 do
		if arena^[yy]^[xx]in este then begin
			test:=false;
			exit;
		end;
	end else test:=false;
end;

procedure siirraaijia;
var
	i,b,p,c,d,xi,yi:integer;
	xf,yf:fixed;
	xx,yy:longint;
	s:array[0..7]of boolean;

const
	su:array[0..3]of byte=(2,4,2,4);
	ts:array[0..3,0..4,0..1]of shortint=(
	((-1,-2),(0,-2),(1,-2),(0,0),(0,0)),
	((1,-1),(1,0),(1,2),(1,2),(1,3)),
	((-1,4),(0,4),(1,4),(0,0),(0,0)),
	((-1,-1),(-1,0),(-1,1),(-1,2),(-1,3)));

begin
	for i:=0 to 1 do with m^[i] do if m^[i].lives>0 then if alive then begin
		for b:=0 to 3 do begin
			s[b]:=true;
			for p:=0 to su[b] do
			if arena^[y.i+ts[b,p,1]]^[x.i+ts[b,p,0]]in este then begin
				s[b]:=false;
				break;
			end;
			if x.i<4 then begin
				s[3]:=false;
			end;
			if y.i<2 then begin
				y.i:=4;
				s[0]:=false;
			end;
			if x.i>width-4 then begin
				s[1]:=false;
			end;
			if y.i>height-6 then begin
				s[2]:=false;
			end;
		end;
		if s[0]and not s[2]then begin
			if (s[1]=false)and(xb>0)then begin
				dec(y.i);
				s[1]:=true;
				for p:=0 to su[1]do
					if arena^[y.i+ts[1,p,1]]^[x.i+ts[1,p,0]]in este then begin
						s[1]:=false;
						break;
					end;
			end;
			if (s[3]=false)and(xb<0)then begin
				dec(y.i);
				s[3]:=true;
				for p:=0 to su[3]do
					if arena^[y.i+ts[3,p,1]]^[x.i+ts[3,p,0]]in este then begin
						s[3]:=false;
						break;
					end;
			end;
		end;
		if key[k[i,0]]then begin
			if dir then begin
				dec(a.l,turnspeed);
				if a.i<32 then a.i:=32;
			end else begin
				inc(a.l,turnspeed);
				if a.i>32 then a.i:=32;
			end;
		end;

		if key[k[i,1]]then begin
			if dir then begin
				inc(a.l,turnspeed);
				if a.i>58 then a.i:=58;
			end else begin
				dec(a.l,turnspeed);
				if a.i<6 then a.i:=6;
			end;
		end;

		if key[k[i,5]]then begin
			if key[k[i,6]]then begin
				if phar then begin
					{startsound(sound[6],6,false);}
					harp:=true;
					h.k:=false;
					h.x.i:=x.i;
					h.y.i:=y.i;
					h.xb:=tab[a.i,0]shl 2;
					h.yb:=tab[a.i,1]shl 2;
					phar:=false;
				end;
			end else begin
				phar:=true;
			end;
		end else begin
			if key[k[i,6]]then begin
				if(not s[2])or((harp)and(h.k))then begin
					harp:=false;
					if jump then begin
						dec(yb,hyppy);
						jump:=false;
					end;
				end;
			end else jump:=true;
		end;
		if s[2]then inc(yb,mtippu);
		case xb>0 of
			true:if s[1] then inc(x.l,xb);
			false:if s[3] then inc(x.l,xb);
		end;
		case yb>0 of
			true:if s[2] then inc(y.l,yb);
			false:if s[0] then inc(y.l,yb);
		end;

		if gtimer>=0 then dec(gtimer);
		if clips[g]<1 then begin
			loaded:=false;
			ctimer:=gclipload[guns[g]];
			clips[g]:=gclip[guns[g]];
		end;
		if ctimer>=0 then	begin
			dec(ctimer);
			if ctimer<0 then begin
				{if grlsound[guns[g]]and 1=1then startsound(sound[25],25,false);}
				loaded:=true;
			end;
		end;
		if (key[k[i,4]])and(loaded)and(not key[k[i,5]])then begin
			if gtimer<0 then begin
				dec(clips[g]);
				gtimer:=gload[guns[g]];
				shoot:=true;
				stimer:=suuliegispd;
				xx:=x.l+tab[a.i,0]shl 2;
				yy:=y.l+tab[a.i,1]shl 2;
				if gshellt[guns[g]]>0 then if random(gshellt[guns[g]])=0 then
					sht:=gshellr[guns[g]];
				{if gsound[guns[g]]>0 then
					if 1=1and gsloop[guns[g]]then begin
						if not soundplaying(gsound[guns[g]])then
						startsound(sound[gsound[guns[g]]],gsound[guns[g]],
						1=1and gsloop[guns[g]]);
					end else
						startsound(sound[gsound[guns[g]]],gsound[guns[g]],
						1=1and gsloop[guns[g]]);}
				for d:=1 to gnum[guns[g]] do
					newblt(guns[g],i,xx,yy,a.i);
				dec(xb,tab[a.i,0]*gpotku[guns[g]]div dvd);
				dec(yb,tab[a.i,1]*gpotku[guns[g]]div dvd);
			end;
		end{ else if 1=1and gsloop[guns[g]]then
			stopsound(gsound[guns[g]])};
		if sht>0 then begin
			dec(sht);
      if sht=0 then newfrg1(8,x.i,y.i,-8000+random(16000),
        -20000-random(20000));
		end;
		if not s[2]then	xb:=xb*mresist div dvd;
		if (xb>0)and(not s[1]) then begin
			{if xb>$8000 then startsound(sound[15],15,false);}
			xb:=0;
		end;
		if (xb<0)and(not s[3]) then begin
			{if xb<-$8000 then startsound(sound[15],15,false);}
			xb:=0;
		end;
		if (yb>0)and(not s[2]) then begin
			{if yb>$8000 then startsound(sound[15],15,false);}
			yb:=0;
		end;
		if (yb<0)and(not s[0]) then begin
			{if yb<-$8000 then startsound(sound[15],15,false);}
			yb:=0;
		end;

		if (key[k[i,5]])and(loaded)then begin
			if key[k[i,4]]and(grange[guns[g]]>0)and(grangeh[guns[g]]=0)then begin
				if rem then begin
					rem:=false;
					c:=grange[guns[g]];
					p:=-1;
					for d:=0 to maxblts do if blt^[d]<>nil then
						if(blt^[d]^.t=guns[g])and(blt^[d]^.a=i)then
							if (blt^[d]^.r<c)and(blt^[d]^.r>12)then begin
								p:=d;
								c:=blt^[d]^.r;
							end;
					if p>-1 then begin
						{startsound(sound[28],28,false);}
						blt^[p]^.r:=1;
					end;
				end;
			end else rem:=true;
			shoot:=false;
			showg:=true;
			mov:=false;
			{if 1=1and gsloop[guns[g]]then
				stopsound(gsound[guns[g]]);}
			if key[k[i,2]]then begin
				if change[0] then begin
					dec(g);
					if g<1 then g:=carry;
					change[0]:=false;
				end;
			end else change[0]:=true;
			if key[k[i,3]]then begin
				if change[1] then begin
					inc(g);
					if g>carry then g:=1;
					change[1]:=false;
				end;
			end else change[1]:=true;
		end else begin
			rem:=true;
			showg:=false;
			if (not key[k[i,3]])and(key[k[i,2]])then begin
				dir:=false;
				if xb>-maxspd then dec(xb,mspeed);
				if a.i>32 then a.i:=64-a.i;
				mov:=true;
			end;
			if (not key[k[i,2]])and(key[k[i,3]])then begin
				dir:=true;
				if xb<maxspd then inc(xb,mspeed);
				if a.i<32 then a.i:=64-a.i;
				mov:=true;
			end;
			if(key[k[i,2]])and(key[k[i,3]])then begin
				if dig then begin
					dig:=false;
					xf.l:=x.l+tab[a.i,0]+tab[a.i,0]shl 1;
					yf.l:=y.l+tab[a.i,1]+tab[a.i,1]shl 1;
					for xx:=-4 to 4 do begin
						xi:=xx+xf.i;
						for yy:=-4 to 4 do begin
							yi:=yy+yf.i;
							if arena^[yi]^[xi]in hajo then if random(3)=0 then
								newfrg2(3,arena^[yi]^[xi],xi,yi,0,0,random(64));
						end;
					end;
					dec(xf.i,7);
					dec(yf.i,7);
					pica(xf.i,yf.i,g1^[hpic[3]],
						g1^[hfrom[3]+random(hfroms[3])],true);
				end;
			end else dig:=true;
			if(not key[k[i,2]])and(not key[k[i,3]])then	mov:=false;
		end;
		if stimer>0 then begin
			dec(stimer);
			if stimer=0 then shoot:=false;
		end;
		{p:=pl[i];
		if(m[p].x.i>x.i-3)and(m[p].x.i<x.i+3)and
			(m[p].y.i>y.i-4)and(m[p].y.i<y.i+6)then begin
				xx:=xb;
				xb:=m[p].xb;
				m[p].xb:=xx;
				xx:=yb;
				yb:=m[p].yb;
				m[p].yb:=xx;
			end;}
		if energy<25 then begin
			if random(energy+7)=0 then begin
				 {if random(3)=0 then if not soundplaying(pchn[i])then
					 startsound(sound[19+random(3)],pchn[i],false);}
				 newfrg1(7,x.i,y.i,xb-bdirp+random(bdirp shl 1),
					 yb-bdirp+random(bdirp shl 1));
			end;
		end;
		if energy<1 then begin
			dtimer[i]:=-8;
			{if 1=1and gsloop[guns[g]]then
				stopsound(gsound[guns[g]]);}
			{startsound(sound[16+random(3)],16,false);}
			shoot:=false;
			showg:=false;
			harp:=false;
			dec(lives);
			alive:=false;
			rtimer:=respawntime;
			b:=0;
			for d:=1 to dieblood do
				newfrg2(7,0,x.i,y.i,0,0,random(64));
			b:=0;
			for d:=1 to diefrags do
				newfrg2(i+1,0,x.i,y.i,0,0,random(64));
			if random(100)>50 then a.i:=16 else a.i:=48;
			if a.i>32 then dir:=true else dir:=false;
		end;
	end else begin
		if rtimer>0 then dec(rtimer);
		if rtimer=0 then begin
			xx:=x.i;
			yy:=y.i;
			repeat
				x.i:=random(width);
				y.i:=random(height);
			until test(x.i,y.i,m^[pls[i]].x.i,m^[pls[i]].y.i,xx,yy);
			while arena^[y.i+5]^[x.i]in vapaa do inc(y.i);
			dec(rtimer);
		end;
		if rtimer<0 then begin
			c:=x.i-viewx shr 1;
			if c<0 then c:=0;
			if c>width-viewx then c:=width-viewx;
			d:=y.i-viewy shr 1;
			if d<0 then d:=0;
			if d>height-viewy then d:=height-viewy;
			if(nx[i]>c-5)and(nx[i]<c+5)and(ny[i]>d-5)and(ny[i]<d+5)then begin
				{startsound(sound[22],22,false);}
				alive:=true;
				shoot:=false;
				{newexp(5,x.i,y.i);}
				xb:=0;
				yb:=0;
				energy:=maxen;
			end;
		end;
	end;
end;

procedure piirra;
var i,ii,b,xi,yi,xh,yh:integer;
	xx,yy:array[0..1]of fixed;
	s:string;
	joo:boolean;
	jep:fixed;

const
	cx1=145;
	cx2=160+viewx;
begin
	cls(v^);
	if frames mod 10=0 then rl:=not(rl);
	for i:=0 to 1 do with m^[i] do begin
		if rtimer<=0 then begin
			if alive then begin
				nx[i]:=x.i-viewx shr 1;
				ny[i]:=y.i-viewy shr 1;
			end else begin
				for b:=0 to 3  do begin
					if nx[i]<x.i-viewx shr 1 then inc(nx[i]);
					if nx[i]>x.i-viewx shr 1 then dec(nx[i]);
					if ny[i]<y.i-viewy shr 1 then inc(ny[i]);
					if ny[i]>y.i-viewy shr 1 then dec(ny[i]);
				end;
			end;
		end else
			if energy<=0 then begin
				nx[i]:=x.i-viewx shr 1;
				ny[i]:=y.i-viewy shr 1;
			end;
		if nx[i]<0 then nx[i]:=0;
		if ny[i]<0 then ny[i]:=0;
		if nx[i]>width-viewx then nx[i]:=width-viewx;
		if ny[i]>height-viewy then ny[i]:=height-viewy;
		if eq[i].i>0 then begin
			inc(ny[i],-eq[i].i+random(eq[i].i shl 1));
			inc(nx[i],-eq[i].i+random(eq[i].i shl 1));
			if nx[i]<0 then nx[i]:=0;
			if ny[i]<0 then ny[i]:=0;
			if nx[i]>width-viewx then nx[i]:=width-viewx;
			if ny[i]>height-viewy then ny[i]:=height-viewy;
		end;
		show(arena^[ny[i]]^[nx[i]],width,viewx,100,v^[ipos[i,1],ipos[i,0]]);
		show(arena^[ny[i]+100]^[nx[i]],width,viewx,viewy-100,v^[ipos[i,1]+100,ipos[i,0]]);
		{pic(ipos[i,0],159,v^,g1^[enupic]);
		pic(ipos[i,0]+16,159,v^,g1^[enupic+1]);}
		if alive then begin
			if energy>0 then hline1(epos[i],energy,161,214+energy div 5,v^);
		end else begin
			b:=maxen-longint(rtimer*(maxen shr 2)div(respawntime shr 2));
			if b>0 then hline1(epos[i],b,161,214+b div 5,v^);
			{if rl then for ii:=0 to 3 do
				picor(epos[i]+29+ii shl 4,159,v^,g1^[plspic+ii]);}
		end;
		picor(epos[i],169,v^,g1^[mliv[i]]);
		writef(epos[i],170,' x '+tostr(lives),mcol[i],v^[0,8],f8^);
		{pic(ipos[i,0],165,v^,g1^[ammpic]);
		pic(ipos[i,0]+16,165,v^,g1^[ammpic+1]);}
		if loaded then begin
			if clips[g]>0 then begin
				b:=longint(clips[g]*maxen div gclip[guns[g]]);
				hline1(epos[i],b,165,235+b div 5,v^);
			end;
		end else begin
			b:=maxen-longint(ctimer*(maxen shr 2) div (gclipload[guns[g]]shr 2));
			if b>0 then hline1(epos[i],b,165,235+b div 5,v^);
			if (rl)and(alive) then for ii:=0 to 2 do
				picor(epos[i]+29+ii shl 4,164,v^,g1^[relpic+ii]);
		end;
	end;
	for i:=0 to 1 do begin
		with m^[i] do begin
			xx[i].i:=x.i-1;
			yy[i].i:=y.i-1;
			xx[i].w:=0;
			yy[i].w:=0;
			inc(xx[i].i,ipos[i,0]);
			inc(yy[i].i,ipos[i,1]);
			dec(xx[i].i,nx[i]);
			dec(yy[i].i,ny[i]);
			ii:=a.i+16;
			if ii>63 then dec(ii,64);
			inc(xx[i].l,tab[a.i,0]shl 4);
			inc(yy[i].l,tab[a.i,1]shl 4);
		end;
	end;
	for i:=0 to maxblts do if blt^[i]<>nil then with blt^[i]^ do begin
		if(x.i>=nx[0])and(x.i<nx[0]+viewx)and
			(y.i>=ny[0])and(y.i<ny[0]+viewy)then begin
				if gpic[t]>0 then
					picor1(x.i-nx[0]+ipos[0,0]-7,y.i-ny[0]+ipos[0,1]-7,
						v^,g1^[gpic[t]+a])
				else
					v^[y.i-ny[0]+ipos[0,1],x.i-nx[0]+ipos[0,0]]:=gcol[t];
			end;
		if(x.i>=nx[1])and(x.i<nx[1]+viewx)and
			(y.i>=ny[1])and(y.i<ny[1]+viewy)then begin
				if gpic[t]>0 then
					picor2(x.i-nx[1]+ipos[1,0]-7,y.i-ny[1]+ipos[1,1]-7,
						v^,g1^[gpic[t]+a])
				else
					v^[y.i-ny[1]+ipos[1,1],x.i-nx[1]+ipos[1,0]]:=gcol[t];
			end;
	end;

	for i:=0 to maxfrags do if frg^[i]<>nil then with frg^[i]^ do begin
		xi:=x.i+7;
		yi:=y.i+7;
		if(xi>=nx[0])and(xi<nx[0]+viewx)and
			(yi>=ny[0])and(yi<ny[0]+viewy)then
			if fpic[t]>0 then
				picor1(x.i-nx[0]+ipos[0,0],y.i-ny[0]+ipos[0,1],v^,g1^[fpic[t]+p])
			else
				v^[yi-ny[0]+ipos[0,1],xi-nx[0]+ipos[0,0]]:=p;
		if(xi>=nx[1])and(xi<nx[1]+viewx)and
			(yi>=ny[1])and(yi<ny[1]+viewy)then
			if fpic[t]>0 then begin
				picor2(x.i-nx[1]+ipos[1,0],y.i-ny[1]+ipos[1,1],v^,g1^[fpic[t]+p])
			end else
				v^[yi-ny[1]+ipos[1,1],xi-nx[1]+ipos[1,0]]:=p;
	end;

	if m^[0].energy<=0 then with m^[0]do begin
		{for ii:=1 to length(died[0])do
			if died[0,ii]<>' 'then
				pico2(160+ii shl 2,dtimer[0],f^[integer(died[0,ii])-65]);}
		writef(163,dtimer[0]+1,died[0],0,v^,f8^);
		writef(162,dtimer[0],died[0],15,v^,f8^);
		if frames and 1=0 then begin
			if rtimer>16 then begin
				if dtimer[0]<2 then inc(dtimer[0]);
			end else dec(dtimer[0]);
		end;
	end;

	if m^[1].energy<=0 then with m^[1]do begin
		{for ii:=1 to length(died[1])do
			if died[1,ii]<>' 'then
				pico1(ii shl 2,dtimer[1],f^[integer(died[1,ii])-65]);}
		writef(3,dtimer[1]+1,died[1],0,v^,f8^);
		writef(2,dtimer[1],died[1],15,v^,f8^);
		if frames and 1=0 then begin
			if rtimer>16 then begin
				if dtimer[1]<2 then inc(dtimer[1]);
			end else dec(dtimer[1]);
		end;
	end;

	for i:=0 to maxexpls do if exp^[i]<>nil then with exp^[i]^ do begin
		xi:=x-nx[0]+ipos[0,0];
		yi:=y-ny[0]+ipos[0,1];
		if(xi>-15)and(xi<=viewx)and(yi>-15)and(yi<=viewy)then
			picor1(xi,yi,v^,g1^[epics[t]+p]);
		xi:=x-nx[1]+ipos[1,0];
		yi:=y-ny[1]+ipos[1,1];
		if(xi>145)and(xi<161+viewx)and(yi>-15)and(yi<=viewy)then
			picor2(xi,yi,v^,g1^[epics[t]+p]);

		dec(timer);
		if timer<0 then begin
			timer:=espeed[t];
			inc(p);
			if p>elen[t] then begin
				dispose(exp^[i]);
				exp^[i]:=nil;
			end;
		end;
	end;

	for i:=1 downto 0 do with m^[i] do if alive then begin
		b:=a.i-5;
		if b<0 then inc(b,63);
		b:=b shr 3;
		xi:=x.i-nx[0]+ipos[0,0]-7;
		yi:=y.i-ny[0]+ipos[0,1]-7;
		if harp then begin
			xh:=h.x.i-nx[0]+ipos[0,0];
			yh:=h.y.i-ny[0]+ipos[0,1];
			line1(xh,yh,xi+7,yi+7);
			picor1(xh-1,yh-1,v^,g1^[127]);
		end;
		joo:=mov;
		if loaded and key[k[i,4]]then joo:=false;
		if joo then
			picor1(xi,yi,v^,g1^[liikpos[i,dir]+frames and 31 shr 3])
		else begin
			if dir then picor1(xi,yi,v^,g1^[b+mpos[i,dir]-3])
			else picor1(xi,yi,v^,g1^[b+mpos[i,dir]]);
		end;
		if (1=1and gfire[guns[g]])and(shoot)then
			picor1(xi,yi,v^,g1^[9+b]);
		{if not loaded then picor1(xi+6,yi+6,v^,g1^[37+i]);}
	end;
	if m^[0].alive then with m^[0] do begin
		picor1(xx[0].i,yy[0].i,v^,g1^[36]);
		if showg then begin
			b:=length(gname[guns[g]]);
			s:=gname[guns[g]];
			for ii:=1 to b do	if s[ii]<>' 'then pico1(xi-(b shl 1)+ii shl 2+4,yi-2,
				f^[integer(s[ii])-65]);
		end;
	end;
	for i:=0 to 1 do with m^[i] do if alive then begin
		b:=a.i-5;
		if b<0 then inc(b,63);
		b:=b shr 3;
		xi:=x.i-nx[1]+ipos[1,0]-7;
		yi:=y.i-ny[1]+ipos[1,1]-7;
		if harp then begin
			xh:=h.x.i-nx[1]+ipos[1,0];
			yh:=h.y.i-ny[1]+ipos[1,1];
			line2(xh,yh,xi+7,yi+7);
			picor2(xh-1,yh-1,v^,g1^[127]);
		end;
		joo:=mov;
		if loaded and key[k[i,4]]then joo:=false;
		if joo then
			picor2(xi,yi,v^,g1^[liikpos[i,dir]+frames and 31 shr 3])
		else begin
			if dir then picor2(xi,yi,v^,g1^[b+mpos[i,dir]-3])
			else picor2(xi,yi,v^,g1^[b+mpos[i,dir]]);
		end;
		if (1=1and gfire[guns[g]])and(shoot)then begin
			picor2(xi,yi,v^,g1^[9+b]);
			{dec(stimer);}
		end;
		{if not loaded then picor2(xi+6,yi+6,v^,g1^[37+i]);}
	end;
	if m^[1].alive then with m^[1] do begin
		picor2(xx[1].i,yy[1].i,v^,g1^[36]);
		if showg then begin
			b:=length(gname[guns[g]]);
			s:=gname[guns[g]];
			for ii:=1 to b do	if s[ii]<>' 'then pico2(xi-(b shl 1)+ii shl 2+4,yi-2,
				f^[integer(s[ii])-65]);
		end;
	end;
	for i:=0 to maxblood do if bld^[i]<>nil then with bld^[i]^ do begin
		if(x.i>=nx[0])and(x.i<nx[0]+viewx)and
			(y.i>=ny[0])and(y.i<ny[0]+viewy)then
				v^[y.i-ny[0]+ipos[0,1],x.i-nx[0]+ipos[0,0]]:=80+random(2);
		if(x.i>=nx[1])and(x.i<nx[1]+viewx)and
			(y.i>=ny[1])and(y.i<ny[1]+viewy)then
				v^[y.i-ny[1]+ipos[1,1],x.i-nx[1]+ipos[1,0]]:=80+random(2);
	end;
{	for i:=0 to maxexpfs do if efs^[i].c>0 then with efs^[i] do begin
		if(x.i>=nx[0])and(x.i<nx[0]+viewx)and
			(y.i>=ny[0])and(y.i<ny[0]+viewy)then
			v^[y.i-ny[0]+ipos[0,1],x.i-nx[0]+ipos[0,0]]:=c;
		if(x.i>=nx[1])and(x.i<nx[1]+viewx)and
			(y.i>=ny[1])and(y.i<ny[1]+viewy)then
			v^[y.i-ny[1]+ipos[1,1],x.i-nx[1]+ipos[1,0]]:=c;
		inc(x.l,xb);
		inc(y.l,yb);
		dec(c);
		if c<104 then c:=0;
	end;
	{xi:=mapx+mapsizex+1;
	hline(mapx,xi,mapy,7,v^);
	hline(mapx,xi,199,7,v^);
	vline(mapy,mapsizey,mapx,7,v^);
	vline(mapy,mapsizey,mapx+mapsizex,7,v^);
	for i:=0 to 1 do with m[i] do if alive then begin
		xi:=x.i div mapmulx-1;
		yi:=y.i div mapmuly-1;
		sprite(4,4,v^[mapy+yi,mapx+xi],f^[26+i]);
	end;}
	if syncon then sync;
	if frames and 3=0 then for i:=1 to cycles do cyclepal(cycle[i,0],cycle[i,1]);
	if loppu<32 then setin(playpal^,loppu);
	if flashb then begin
		if flash=flashlen then setin(flpal^,flbr);
		dec(flash);
		if flash<0 then begin
			flashb:=false;
			restpal(playpal^);
		end;
	end;
	flip(v^,vga);
end;

procedure testexpl;

var i,b,c,ii,ka,xi,yi,mov:longint;
begin
	for i:=0 to maxexpls do if (exp^[i]<>nil)then with exp^[i]^do begin
		if (p<1)and(epower[t]>0) then begin
			xi:=x+7;
			yi:=y+8;
			b:=erange[t];
				 if m^[0].alive then
			if(jo[0])and(m^[0].x.i<xi+b)and(m^[0].x.i>xi-b)and
				(m^[0].y.i<yi+b)and(m^[0].y.i>yi-b)then begin
					jo[0]:=false;
					ii:=m^[0].x.i-xi;
					c:=b-abs(ii);
					ka:=c;
					if c>0 then begin
						if ii>0 then inc(m^[0].xb,longint(emove[t]*c));
						if ii<0 then dec(m^[0].xb,longint(emove[t]*c));
					end;

					ii:=m^[0].y.i-yi;
					c:=b-abs(ii);
					ka:=ka+c;
					if c>0 then begin
						if ii>0 then inc(m^[0].yb,longint(emove[t]*c));
						if ii<0 then dec(m^[0].yb,longint(emove[t]*c));
					end;
					ka:=ka shr 1;
					c:=epower[t]*ka div erange[t];
					dec(m^[0].energy,c);
					if mkmode then ka:=ka shl 2;
					for c:=1 to ka do begin
						newfrg2(7,0,m^[0].x.i,m^[0].y.i,
							m^[0].xb div 2,m^[0].yb div 2,random(64));
					end;
					if m^[0].energy>0 then if random(3)=0 then
					{if not soundplaying(pchn[0])then
						startsound(sound[19+random(3)],pchn[0],false);}
				end;
				 if m^[1].alive then
			if(jo[1])and(m^[1].x.i<xi+b)and(m^[1].x.i>xi-b)and
				(m^[1].y.i<yi+b)and(m^[1].y.i>yi-b)then begin
					jo[1]:=false;
					ii:=m^[1].x.i-xi;
					c:=b-abs(ii);
					ka:=c;
					if c>0 then begin
						if ii>0 then inc(m^[1].xb,longint(emove[t]*c));
						if ii<0 then dec(m^[1].xb,longint(emove[t]*c));
					end;
					ii:=m^[1].y.i-yi;
					c:=b-abs(ii);
					ka:=ka+c;
					if c>0 then begin
						if ii>0 then inc(m^[1].yb,longint(emove[t]*c));
						if ii<0 then dec(m^[1].yb,longint(emove[t]*c));
					end;
					ka:=ka shr 1;
					c:=epower[t]*ka div erange[t];
					dec(m^[1].energy,c);
					if mkmode then ka:=ka shl 2;
					for c:=1 to ka do begin
						newfrg2(7,0,m^[1].x.i,m^[1].y.i,
							m^[1].xb div 2,m^[1].yb div 2,random(64));
					end;
					if m^[1].energy>0 then if random(3)=0 then
					{if not soundplaying(pchn[1])then
						startsound(sound[19+random(3)],pchn[1],false);}
				end;
			dec(yi);
			mov:=emove[t]div 10;
			for ka:=0 to maxblts do if blt^[ka]<>nil then
			if 1=1and gexpvaik[blt^[ka]^.t]then
				if(blt^[ka]^.x.i<xi+b)and(blt^[ka]^.x.i>xi-b)and
				(blt^[ka]^.y.i<yi+b)and(blt^[ka]^.y.i>yi-b)then begin
					ii:=blt^[ka]^.x.i-xi;
					c:=b-abs(ii);
					if c>0 then begin
						if ii>0 then inc(blt^[ka]^.xb,c*mov);
						if ii<0 then dec(blt^[ka]^.xb,c*mov);
					end;
					ii:=blt^[ka]^.y.i-yi;
					c:=b-abs(ii);
					if c>0 then begin
						if ii>0 then inc(blt^[ka]^.yb,c*mov);
						if ii<0 then dec(blt^[ka]^.yb,c*mov);
					end;
				end;
			for ka:=0 to maxfrags do if frg^[ka]<>nil then
			if 1=1and fexpvaik[frg^[ka]^.t]then
				if(frg^[ka]^.x.i<xi+b)and(frg^[ka]^.x.i>xi-b)and
				(frg^[ka]^.y.i<yi+b)and(frg^[ka]^.y.i>yi-b)then begin
					ii:=frg^[ka]^.x.i-xi;
					c:=b-abs(ii);
					if c>0 then begin
						if ii>0 then inc(frg^[ka]^.xb,c*mov);
						if ii<0 then dec(frg^[ka]^.xb,c*mov);
					end;
					ii:=frg^[ka]^.y.i-yi;
					c:=b-abs(ii);
					if c>0 then begin
						if ii>0 then inc(frg^[ka]^.yb,c*mov);
						if ii<0 then dec(frg^[ka]^.yb,c*mov);
					end;
				end;
		end;
	end;
end;

procedure siirraharps;
var p,i:integer;
	yi,xi:longint;
const len=16;
	vasta:array[0..1]of byte=(1,0);
begin
	for i:=0 to 1 do if m^[i].harp then with m^[i] do begin
		inc(h.x.l,h.xb);
		inc(h.y.l,h.yb);
		xi:=h.x.i-x.i;
		yi:=h.y.i-y.i;
		h.k:=false;
		if(arena^[h.y.i]^[h.x.i]in este)or(h.y.i>he)then begin
			{if not h.k then for p:=0 to 4 do
				newfrg2(3,h.x.i,h.y.i,0,0,random(64));}
			h.k:=true;
			h.xb:=0;
			h.yb:=0;
		end;
		p:=vasta[i];
		if m^[p].alive and(h.x.i-3<m^[p].x.i)and(h.x.i+3>m^[p].x.i)and
			(h.y.i-3<m^[p].y.i)and(h.y.i+3>m^[p].y.i)then begin
			h.k:=true;
			h.xb:=0;
			h.yb:=0;
			h.x.i:=m^[p].x.i;
			h.y.i:=m^[p].y.i;
			inc(m^[p].xb,-(xi shl 5));
			inc(m ^[p].yb,-(yi shl 5));
		end;
		if h.k then begin
			inc(xb,xi shl 5);
			inc(yb,yi shl 5);
		end else begin
			inc(h.yb,300);
			inc(h.xb,-(xi shl 2));
			inc(h.yb,-(yi shl 2));
		end;
		if(h.x.i<0)or(h.x.i>wi)or(h.y.i<0)then harp:=false;
	end;
end;

procedure siirrapateja;
var e,d,i,p:integer;
	boom,jumi,pomp:boolean;
	xx,yy:fixed;
	xi,yi:integer;
label pois;
begin
	for i:=0 to maxblts do if blt^[i]<>nil then with blt^[i]^ do begin
		boom:=false;
		inc(x.l,xb);
		inc(y.l,yb);
		if(x.i<0)or(x.i>wi)or(y.i<0)then t:=0;
		if t=0 then begin
			dispose(blt^[i]);
			blt^[i]:=nil;
			goto pois;
		end;
		pomp:=false;
		if gboing[t]>0 then begin
			xx.l:=x.l+xb;
			yy.l:=y.l+yb;
			if(xx.i<0)or(xx.i>wi)then t:=0;
			if t=0 then begin
				dispose(blt^[i]);
				blt^[i]:=nil;
				goto pois;
			end;
			if(arena^[y.i]^[xx.i]in este)then begin
				if gboing[t]<>100 then begin
					xb:=-(xb*gboing[t]div dvd);
					yb:=yb*4 div 5;
				end else begin
					xb:=-xb;
				end;
				pomp:=true;
			end;
			if(arena^[yy.i]^[x.i]in este)or(yy.i>he)then begin
				if gboing[t]<>100 then begin
					yb:=-(yb*gboing[t]div dvd);
					xb:=xb*4 div 5;
				end else begin
					yb:=-yb;
				end;
				pomp:=true;
			end;
		end;
		if (gpera[t]>0)and(frames mod gptimer[t]=0)then
			newexp(gpera[t],x.i,y.i);

		if (gfpera[t]>0)and(frames mod gfptimer[t]=0)then
			if gfp12[t]and 1=1 then
				newfrg1(gfpera[t],x.i,y.i,xb div 3,yb div 3)
			else
				newfrg2(gfpera[t],0,x.i,y.i,xb div 3,yb div 3,random(64));
		{if ghoming[t]=0 then begin}
			if grange[t]>0 then begin
				dec(r);
				if r<0 then boom:=true;
			end;
		{end else begin
			xi:=abs(m[r].x.i-x.i);
			yi:=abs(m[r].y.i-y.i);
			if xi>0 then xb:=
				(xb shl 5+((m[r].x.l-x.l)div xi)*ghoming[t]div dvd)div 33
			else xb:=0;
			if yi>0 then yb:=
				(yb shl 5+((m[r].y.l-y.l)div yi)*ghoming[t]div dvd)div 33
			else yb:=0;
		end;}
		jumi:=false;
		if(arena^[y.i]^[x.i]in este)or
			(y.i>=he)then begin
			if {gboing[t]<100}not pomp then begin
				jumi:=true;
				if (1=1and gheti[t]) then boom:=true else begin
					xb:=0;
					yb:=0;
				end;
			end;
		end else begin
			if ggrav[t]<>0 then
				inc(yb,ggrav[t]);
			if gpics[t]>0 then if frames and 7=0 then begin
				inc(a);
				if a>gpics[t]then a:=0;
			end;
		end;
		{if gboing[t]>80 then if pomp and not jumi then
			startsound(sound[29],29,false);}
		for p:=0 to 1 do if m^[p].alive then
			if(x.i>=nx[p])and(x.i<nx[p]+viewx)and
				(y.i>=ny[p])and(y.i<ny[p]+viewy)then
				if (m^[p].alive)then begin
					xi:=x.i-nx[p]+ipos[p,0];
					yi:=y.i-ny[p]+ipos[p,1];
					if(v^[yi-1,xi]in plrs[p])or
					(v^[yi+1,xi]in plrs[p])or
					(v^[yi,xi-1]in plrs[p])or
					(v^[yi,xi+1]in plrs[p])then begin
						inc(m^[p].xb,gmove[t]*xb div dvd);
						inc(m^[p].yb,gmove[t]*yb div dvd);
						dec(m^[p].energy,gpower[t]);
						if 1=1 and gbldl[t] then
							for d:=1 to gblood[t] do newfrg2(7,0,x.i,y.i,
								m^[p].xb div 2,m^[p].yb div 2,random(64))
						else
							for d:=1 to gblood[t] do newfrg1(7,x.i,y.i,
								xb div 2-bdirp+random(bdirp shl 1),
								yb div 2-bdirp+random(bdirp shl 1));
						if (1=1and ghit[t]) then begin
							if m^[p].energy>0 then if random(3)=0 then
							{if not soundplaying(pchn[p])then
								startsound(sound[19+random(3)],pchn[p],false);}
							boom:=(1=1and gboom[t]);
							if not boom then begin
								dispose(blt^[i]);
								blt^[i]:=nil;
								goto pois;
							end;
						end;
					end;
				end;
		if boom then begin
			if gexpl[t]>0 then newexp(gexpl[t],x.i,y.i);
			{if gesound[t]>0 then
				startsound(sound[gesound[t]],gesound[t],false);}
			e:=gfrags[t];
			if e>0 then
				if 1=1 and gfto[t] then begin
					if jumi then for d:=1 to gfrags[t]do
						newfrg2(gftype[t],0,x.i,y.i,0,0,random(64));
				end else begin
					for d:=1 to gfrags[t]do
						newfrg2(gftype[t],0,x.i,y.i,0,0,random(64));
				end;
			e:=ghole[t];
			if e>0 then
				pica(x.i-7,y.i-7,g1^[hpic[e]],
				g1^[hfrom[e]+random(hfroms[e])],(1=1and hto[e]));
			dispose(blt^[i]);
			blt^[i]:=nil;
		end;
		pois:
	end;
end;

procedure siirrabld;
var i,b:integer;
label pois;
begin
	for i:=0 to maxblood do if bld^[i]<>nil then with bld^[i]^ do begin
		{xb:=xb*ores div odiv;
		yb:=yb*ores div odiv;}
		inc(x.l,xb);
		inc(y.l,yb);
		if(x.i<0)or(x.i>wi)or(y.i<0)then t:=false;
		if not t then begin
			dispose(bld^[i]);
			bld^[i]:=nil;
			goto pois;
		end;
		if arena^[y.i]^[x.i] in vapaa then inc(yb,tippu);
		if(y.i>he)then begin
			dispose(bld^[i]);
			bld^[i]:=nil;
			goto pois;
		end;
		if(arena^[y.i]^[x.i]in hajo)then begin
			arena^[y.i]^[x.i]:=82+random(3);
			dispose(bld^[i]);
			bld^[i]:=nil;
			goto pois;
		end;
		if arena^[y.i]^[x.i]in stone then begin
			arena^[y.i]^[x.i]:=85+random(3);
			dispose(bld^[i]);
			bld^[i]:=nil;
			goto pois;
		end;
		{xb:=bresist*xb div dvd;
		yb:=bresist*yb div dvd;}
		{if(abs(yb)<5000)and(abs(xb)<5000)then begin
			arena[y.i]^[x.i]:=79+random(3);
			t:=0;
		end;}
		pois:
	end;
end;

procedure siirrafrag;
var i,e,d,b,xi,yi,xs,ys:integer;
	boom,pomp:boolean;
	xx,yy:fixed;
label pois;
begin
	for i:=0 to maxfrags do if frg^[i]<>nil then with frg^[i]^ do begin
		boom:=false;
		inc(x.l,xb);
		inc(y.l,yb);
		xi:=x.i+7;
		yi:=y.i+7;
		if(xi<0)or(xi>wi)or(yi<0)then t:=0;
		if t=0 then begin
			dispose(frg^[i]);
			frg^[i]:=nil;
			goto pois;
		end;
		pomp:=false;
		if fboing[t]>0 then begin
			xx.l:=x.l+xb;
			yy.l:=y.l+yb;
			inc(xx.i,7);
			inc(yy.i,7);
			if(xx.i<0)or(xx.i>wi)then t:=0;
			if t=0 then begin
				dispose(frg^[i]);
				frg^[i]:=nil;
				goto pois;
			end;
			if(arena^[yi]^[xx.i]in este)then begin
				xb:=-(xb*fboing[t]div dvd);
				yb:=yb*4 div 5;
				pomp:=true;
			end;
			if(arena^[yy.i]^[xi]in este)or(yy.i>he)then begin
				yb:=-(yb*fboing[t]div dvd);
				xb:=xb*4 div 5;
				pomp:=true;
			end;
		end;
		if (1=1and ftbld[t])and(fbdelay[t]>0)then
			if frames mod fbdelay[t]=0 then
				newbld(xi,yi,xb div 4,yb div 4);
		{if frange[t]>0 then begin
			dec(r);
			if r<0 then boom:=true;
		end;}
{		jumi:=false;}
		if(arena^[yi]^[xi]in este)or
			(yi>=he)then begin
			if {(not pomp)and}(frange[t]=0)then begin{}
{				jumi:=true;}
				if 1=1 and fdpic[t] then
				picb(x.i,y.i,g1^[fpic[t]+p]);
				boom:=true;
			end;{}
		end else begin
			if not pomp then if(fpera[t]>0)and(frames mod fpdelay[t]=0)then
				newexp(fpera[t],xi,yi);
			inc(yb,fgrav[t]);
		end;
		if fpics[t]>0 then if frames and 7=0 then begin
			inc(p);
			if p>fpics[t] then p:=0;
		end;
		{xb:=fresist[t]*xb div dvd;
		yb:=fresist[t]*yb div dvd;}
		if frange[t]>0 then begin
			dec(r);
			if r<0 then boom:=true;
		end;
{		if fsound[t]>0 then if pomp and not jumi then
			startsound(sound[fsound[t]],fsound[t],false);}
		if not boom then if (fpower[t]>0){or(1=1and fboom[t])}then begin
			for b:=0 to 1 do if m^[b].alive then
			if(xi>=nx[b])and(xi<nx[b]+viewx)and
				(yi>=ny[b])and(yi<ny[b]+viewy)then
				if (m ^[b].alive)then begin
					xs:=xi-nx[b]+ipos[b,0];
					ys:=yi-ny[b]+ipos[b,1];
					if(v^[ys-1,xs]in plrs[b])or
					(v^[ys+1,xs]in plrs[b])or
					(v^[ys,xs-1]in plrs[b])or
					(v^[ys,xs+1]in plrs[b])then begin
						inc(m^[b].xb,fmove[t]*xb div dvd);
						inc(m^[b].yb,fmove[t]*yb div dvd);
						if random(frandom[t])=0 then dec(m^[b].energy,fpower[t]);
						{if m^[b].energy>0 then if random(3)=0 then
							if not soundplaying(pchn[b])then
							startsound(sound[19+random(3)],pchn[b],false);}
						for d:=1 to fblood[t] do
							newfrg1(7,xi,yi,xb div 2-bdirp+random(bdirp shl 1),
							yb div 2-bdirp+random(bdirp shl 1));
						boom:=1=1and fboom[t];
						if fhit[t]=1then if not boom then begin
							dispose(frg^[i]);
							frg^[i]:=nil;
							goto pois;
						end;
					end;
				end;
		end;
		if boom then begin
			{if fsound[t]>0 then
				startsound(sound[fsound[t]],fsound[t],false);}
			if fexpl[t]>0 then newexp(fexpl[t],xi,yi);
			if fhole[t]>0 then begin
				e:=fhole[t];
				pica(x.i,y.i,g1^[hpic[e]],g1^[hfrom[e]+random(hfroms[e])],true);
			end;
			e:=ffrags[t];
			if e>0 then
				for d:=1 to ffrags[t]do
					newfrg2(fftype[t],0,xi,yi,0,0,random(64));
			dispose(frg^[i]);
			frg^[i]:=nil;
		end;
		pois:
	end;
end;

procedure weapons;

procedure flop(var a,b);assembler;
asm
	push ds
	lds si,a
	les di,b
	mov cx,4000
	db 66h;rep movsw
	pop ds
end;
type
	tjep=array[0..40000]of byte;
var i,w,pl:integer;
	wp:array[0..1]of integer;
	c:array[0..1]of boolean;
	jep:^tjep;
	wps:array[0..1]of set of byte;
begin
	new(jep);
	for i:=0 to 1 do begin
		m^[i].guns[1]:=random(guns)+1;
		m^[i].clips[1]:=gclip[m^[i].guns[1]];
		wp[i]:=1;
		wps[i]:=[];
	end;
	piirra;
	flop(v^[27],jep^);
	writef(105,4,'Select your weapons:',0,vga,f8^);
	writef(106,3,'Select your weapons:',15,vga,f8^);
	writef(wpos[0]-1,16,names^[0],0,vga,f8^);
  writef(wpos[0],15,names^[0],mcol[0]+2,vga,f8^);
	writef(wpos[1]-1,16,names^[1],0,vga,f8^);
  writef(wpos[1],15,names^[1],mcol[1]+2,vga,f8^);
	pl:=0;
	repeat
	flop(jep^,v^[27]);
	for i:=0 to 1 do if wp[i]<=carry then begin
		writef(wpos[i]-1,21+wp[i]shl 3,'<                     >',0,v^,f8^);
		writef(wpos[i],20+wp[i]shl 3,'<                     >',10,v^,f8^);
		for w:=1 to wp[i] do begin
			writef(wpos[i]+9,21+w shl 3,gname[m^[i].guns[w]],0,v^,f8^);
			writef(wpos[i]+10,20+w shl 3,gname[m^[i].guns[w]],11,v^,f8^);
		end;
		if key[k[i,2]]then begin
			if c[i]then begin
				{startsound(sound[26],0,false);}
				c[i]:=false;
				dec(m^[i].guns[wp[i]]);
				if m^[i].guns[wp[i]]in wps[i] then dec(m^[i].guns[wp[i]]);
				if m^[i].guns[wp[i]]<1 then m^[i].guns[wp[i]]:=guns;
			end;
		end;
		if key[k[i,3]]then begin
			if c[i]then begin
				{startsound(sound[27],0,false);}
				c[i]:=false;
				inc(m^[i].guns[wp[i]]);
				if m^[i].guns[wp[i]]in wps[i] then inc(m^[i].guns[wp[i]]);
				if m^[i].guns[wp[i]]>guns then m^[i].guns[wp[i]]:=1;
			end;
		end;
		if key[k[i,4]]then begin
			if c[i]then begin
				{startsound(sound[28],0,false);}
				c[i]:=false;
				wps[i]:=wps[i]+[m^[i].guns[wp[i]]];
				inc(wp[i]);
				repeat w:=random(guns)+1 until not(w in wps[i]);
				m^[i].guns[wp[i]]:=w;
				m^[i].clips[wp[i]]:=gclip[w];
			end;
		end;
		if not key[k[i,2]]and not key[k[i,3]]and not key[k[i,4]]then c[i]:=true;
	end;
	sync;
	if pl<33 then begin
		setin(playpal^,pl);
		inc(pl);
	end;
	flop(v^[27],vga[27]);
	until(wp[0]>carry)and(wp[1]>carry);
	for i:=0 to 1 do begin
		m^[i].g:=1;
		for w:=1 to carry do begin
			m^[i].clips[w]:=gclip[m^[i].guns[w]];
		end;
	end;
	while pressed do;
	restpal(playpal^);
	dispose(jep);
end;

{procedure screenshot;
var i:integer;
begin
	i:=0;
	while exist('screen'+tostr(i)+'.pcx')and(i<99)do inc(i);
	save_pcx('screen'+tostr(i)+'.pcx');
end;}

procedure kaikki;
begin
		{if key[kbf12]then screenshot;}
		siirrapateja;
		siirrafrag;
		testexpl;
		siirraaijia;
		siirrabld;
		siirraharps;
		inc(frames);
end;

procedure playgame;
var i,pl:integer;
	st,lframe:longint;
	endg:boolean;
begin
	weapons;
	for i:=0 to 1 do with m^[i] do begin
		repeat
			x.i:=random(width);
			y.i:=random(height);
		until test(x.i,y.i,m^[pls[i]].x.i,m^[pls[i]].y.i,-viewx,-viewy);
		nx[i]:=0;
		ny[i]:=0;
		m^[i].lives:=startlives;
	end;
{	fillchar(efs^,sizeof(efs^),0);}
	{fillchar(hrp^,sizeof(hrp^),0);}
	{startsound(sound[23],23,false);}
	frames:=0;
	st:=time;
	loppu:=loppuaika;
	endg:=false;
	repeat
		if key[kbp] then begin
			while key[kbp]do;
			while not key[kbp]do;
			while key[kbp]do;
		end;
		piirra;
		kaikki;
		if(m^[0].lives<1)or(m^[1].lives<1)then endg:=true;
		for pl:=0 to 1 do if eq[pl].i>0 then dec(eq[pl].l,eqspeed);
		if (key[1])and(endg=false) then begin
			loppu:=31;
			endg:=true;
		end;
		if endg then dec(loppu);
	until loppu<0;
end;

{procedure alkuvalikko;
type
	pics=array[0..12]of pic16;
var
	p:^pics;
	pc:pic16;
	i,x,y,fad:byte;
	c:integer;
const
	choices=3;
	texts:array[1..choices]of string[7]=(
	'Play!','Options...','Quit');
	dests:array[1..choices]of procedure=(playgame,playgame,nil);
	quit=3;
label uus;
begin
	new(p);
	loaddata('menu.chr',p^,4,sizeof(pics));
	for i:=0 to 12 do begin
		for x:=0 to 15 do for y:=0 to 15 do
			pc[x,y]:=p^[i,y,x];
		p^[i]:=pc;
	end;
	uus:
	piirra;
	{for i:=4 to 0 do picor(145+i shl 3,10,v^,p^[i]);}
  {fad:=1;
	flip(v^,vga);
	x:=0;
	c:=1;
	repeat
		writef(0,0,tostr(c),15,vga,f^);
		if x=0 then begin
			if pressed then x:=1;
			if key[kbup]then dec(c);
			if key[kbdown]then inc(c);
		end;
		if not pressed then x:=0;
		sync;
		if fad<32 then begin
			inc(fad);
			setin(playpal^,fad);
		end;
	until key[kbenter];
	if @dests[c]<>nil then dests[c];
	if c<>quit then goto uus;
	dispose(p);
end;}

procedure play;
var i:integer;
begin
	fillchar(m^,sizeof(m^),0);
	fillchar(blt^,sizeof(blt^),0);
	fillchar(bld^,sizeof(bld^),0);
	fillchar(exp^,sizeof(exp^),0);
	fillchar(frg^,sizeof(frg^),0);
	for i:=0 to 255 do setpal(i,0,0,0);
	keyinit;
	fillarea;
	for i:=0 to 1 do with m^[i] do begin
		if random(100)>50 then a.i:=16 else a.i:=48;
		if a.i>32 then dir:=true else dir:=false;
		energy:=maxen;
		loaded:=true;
		change[0]:=true;
		change[1]:=true;
		alive:=false;
		rtimer:=respawntime;
		eq[i].i:=0;
		shoot:=false;
		nx[i]:=0;
		ny[i]:=0;
		lives:=0;
	end;
	{alkuvalikko;{}
	playgame;{}
	keydone;
end;

{procedure Initsound;
var i:integer;
const names:array[1..numsounds]of string[8]=
('SHOTGUN','SHOT','RIFLE','BAZOOKA','BLASTER','THROW','LARPA','EXP3A','EXP3B',
'EXP2','EXP3','EXP4','EXP5','DIRT','BUMP','DEATH1','DEATH2','DEATH3','HURT1',
'HURT2','HURT3','ALIVE','BEGIN','DROPSHEL','RELOADED','MOVEUP','MOVEDOWN',
'SELECT','BOING','BURNER');
begin
	writeln('Initializing sound system...');
	if not(GetSettings(BaseIO, IRQ, DMA, DMA16))
		then
			begin
				writeln('Error initializing:  Invalid or non-existent BLASTER environment variable');
				Halt(1);
			end
		else
			begin
				if not(InitSB(BaseIO, IRQ, DMA, dma16))
				then
					begin
						writeln('Error initializing sound card');
						writeln('Incorrect base IO address, sound card not installed, or broken');
						Halt(2);
					end;
				if SixteenBit
					then writeln('BaseIO=', HexW(BaseIO), 'h    IRQ', IRQ, '    DMA8=', DMA, '    DMA16=', DMA16)
					else writeln('BaseIO=', HexW(BaseIO), 'h        IRQ', IRQ, '        DMA8=', DMA);
				end;
	write('DSP version ', DSPVersion:0:2, ':  ');
	if SixteenBit
		then write('16-bit, ')
		else write('8-bit, ');
	if AutoInit
		then writeln('Auto-initialized')
		else writeln('Single-cycle');
	if not(InitXMS)
		then
			begin
				writeln('Error initializing extended memory');
				writeln('HIMEM.SYS must be installed');
				Halt(3);
			end
		else
			begin
				writeln('Extended memory succesfully initialized');
				write('Free XMS memory:  ', GetFreeXMS, 'k  ');
				if GetFreeXMS < XMSRequired
					then
						begin
							writeln('Insufficient free XMS');
							Halt(5);
						end
					else begin
						write('Loading sounds...');
						if SharedEMB then InitSharing;
						OpenSoundResourceFile('LIERO.SND');
						for i:=1 to numsounds do
							loadsound(sound[i],names[i]);
						closesoundresourcefile;
					end;
				end;
	InitMixing;
	writeln('OK');
end;}

{procedure Shutdown;
var i:integer;
begin
	ShutdownMixing;
	ShutdownSB;
	for i := 1 to NumSounds do
		FreeSound(Sound[i]);
	if SharedEMB then ShutdownSharing;
	writeln;
end;}

function eta(a,b,c,d:integer):integer;
begin
	eta:=round(sqrt(sqr(a-c)+sqr(b-d)));
end;

procedure asetaalku;

var
	j:pic16;
	t:pic8;
	p:font;
	pic,i,x,y:integer;
	nf:text;

{const size:array[0..2,0..4]of byte=((9,8,6,5,3),(7,6,5,4,2),(5,4,3,2,0));}
begin
	for i:=1 to paramcount do begin
		if not mkmode then if(paramstr(i)='/MK')or(paramstr(i)='/mk')then begin
			for x:=1 to frags do fblood[x]:=fblood[x]shl 2;
			for x:=1 to guns do gblood[x]:=gblood[x]shl 2;
			mkmode:=true;
			dieblood:=dieblood shl 2;
		end;
		if(paramstr(i))='+'then syncon:=false;
	end;
	loadpal(playpal^,'play.pal');
	for i:=0 to 255 do begin
		flpal^[i,0]:=(playpal^[i,0]+48)shr 1;
		flpal^[i,1]:=(playpal^[i,1]+48)shr 1;
		flpal^[i,2]:=(playpal^[i,2]+48)shr 1;
	end;
	loaddata('play2.chr',g1^,4,sizeof(gfx16));
	for i:=0 to g1s do begin
		for x:=0 to 15 do for y:=0 to 15 do
			j[y,x]:=g1^[i,x,y];
		g1^[i]:=j;
	end;
	for x:=0 to 15 do for y:=0 to 15 do begin
		g1^[87,x,y]:=20+random(4);
		g1^[88,x,y]:=20+random(4);
		g1^[169,x,y]:=16+random(4);
		g1^[170,x,y]:=16+random(4);
		g1^[37,x,y]:=94+random(4);
		g1^[38,x,y]:=94+random(4);
	end;
	loaddata('bigfonts.chr',f8^,4,sizeof(fonts8));
	for i:=0 to 249 do begin
		for x:=0 to 7 do for y:=0 to 7 do
			t[y,x]:=f8^[i,x,y];
		f8^[i]:=t;
	end;
	loaddata('pikku.chr',f^,4,sizeof(fonts));
	for i:=0 to fon do begin
		for x:=0 to 3 do for y:=0 to 3 do
			p[y,x]:=f^[i,x,y];
		f^[i]:=p;
	end;
	for i:=-32 to 32 do begin
		tab[i+32,0]:=round(sin(i*pi/32)*divd);
		tab[i+32,1]:=round(-cos(i*pi/32)*divd);
	end;
	{for pic:=0 to 4 do for x:=0 to 15 do for y:=0 to 15 do begin
		g1^[pic+40,x,y]:=0;
		i:=eta(x-1+random(3),y-1+random(3),7,7);
		if i<size[0,pic] then g1^[pic+40,x,y]:=121-i shl 1-pic shl 1;
		g1^[pic+45,x,y]:=0;
		i:=eta(x-1+random(3),y-1+random(3),7,7);
		if i<size[1,pic] then g1^[pic+45,x,y]:=121-i shl 1-pic shl 1;
		g1^[pic+50,x,y]:=0;
		i:=eta(x-1+random(3),y-1+random(3),7,7);
		if i<size[2,pic] then g1^[pic+50,x,y]:=121-i shl 1-pic shl 1;
	end;}
	if exist('names.dat')then begin
		assign(nf,'names.dat');
		reset(nf);
		x:=0;
		repeat readln(nf,names^[0]);inc(x);until names^[0]='';
		reset(nf);
		for y:=0 to random(x)do readln(nf,names^[0]);
		reset(nf);
		repeat
			for y:=0 to random(x)do readln(nf,names^[1]);
		until names^[0]<>names^[1];
		close(nf);
	end;
{	if exist('names2.dat')then begin
		assign(nf,'names2.dat');
		reset(nf);
		x:=0;
		repeat readln(nf,names^[1]);inc(x);until names^[1]='';
		reset(nf);
		for y:=0 to random(x)do readln(nf,names^[0]);
		close(nf);
	end;}
	for i:=0 to 1 do died[i]:=names^[i]+' died';
end;

begin
	Randomize;
	textattr:=7;
	clrscr;
	textattr:=(4 shl 4+15);
	write(' LIERO v',version,' by Joosa');
	textattr:=textattr-8;
	write(' - initializing...                                        ');
	textattr:=7;
	mark(hs);
	new(v);
	new(blt);
	new(exp);
	new(bld);
	new(frg);
	new(g1);
	new(f);
	new(f8);
	new(playpal);
	new(flpal);
	new(names);
	new(m);
{	new(efs);}
	if init(arena,width,height)then begin
	writeln;
	{initsound;}
	write('Loading graphics...');
	asetaalku;
	writeln('OK');
	writeln;
	if mkmode then writeln('Mortal Kombat mode ON');
	if not syncon then writeln('Slow CPU mode ON');
	writeln('Press any key...');
	este:=sand+mud+stone;
	hajo:=sand+mud;
	alue:=sand+mud+vapaa;
	if readkey=#0 then readkey;
		setmode(19);
		play;
		setmode(3);
	{shutdown;}
	delay(10);
	done(arena);
	end else begin
		writeln('Insufficient conventional memory');
	end;
	release(hs);
end.
