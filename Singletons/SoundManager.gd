extends Node

enum Sounds {ACCEPT, BLIP, DEATH, DECLINE, EXPLOSION, LEVELUP, SHOOT}

var volume = SettingsNode.volume / 20

#	0	=  MUTE
#	1	= -80.0dB	=	0.000001%
#	2	= -70.0dB	=	0.00001%
#	3	= -60.0dB	=	0.0001%		(Borderline inaudible here)
#	4	= -50.0dB	=	0.001%
#	5	= -40.0dB	=	0.01%
#	6	= -35.0dB
#	7	= -30.0dB	=	0.1%
#	8	= -25.0dB
#	9	= -20.0dB	=	1.0%
#	10	= -17.0dB
#	11	= -14.0dB
#	12	= -11.5dB
#	13	= -9.0dB	=	12.5%
#	14	= -7.5dB	
#	15	= -6.0dB	=	25.0%
#	16	= -4.5dB
#	17	= -3.0dB	=	50.0%
#	18	= -2.0dB
#	19	= -1.0dB
#	20	=  0.0dB	=	100.0%

func getDBVolume(volume):
	match int(volume):
		0:
			return -1000.0
		1:
			return -80.0
		2:
			return -70.0
		3:
			return -60.0
		4:
			return -50.0
		5:
			return -40.0
		6:
			return -35.0
		7:
			return -30.0
		8:
			return -25.0
		9:
			return -20.0
		10:
			return -17.0
		11:
			return -14.0
		12:
			return -11.5
		13:
			return -9.0
		14:
			return -7.5
		15:
			return -6.0
		16:
			return -4.5
		17:
			return -3.0
		18:
			return -2.0
		19:
			return -1.0
		20:
			return 0.0
		_:
			return -100.0

func updateVolume():
	# Get the volume setting
	volume = SettingsNode.volume / 5 # ranges 0-100 by increments of 5
	var dBVolume = getDBVolume(volume)
	# Update all of the SFX Nodes
	$AcceptSFX.volume_db = dBVolume
	$BlipSFX.volume_db = dBVolume
	$DeathSFX.volume_db = dBVolume
	$DeclineSFX.volume_db = dBVolume
	$ExplosionSFX.volume_db = dBVolume
	$LevelUpSFX.volume_db = dBVolume
	$ShootSFX.volume_db = dBVolume

func playSFX(soundID):
	# Ignore if muted
	if volume == 0:
		pass
	
	match soundID:
		ACCEPT:
			$AcceptSFX.play()
		BLIP:
			$BlipSFX.play()
		DEATH:
			$DeathSFX.play()
		DECLINE:
			$DeclineSFX.play()
		EXPLOSION:
			$ExplosionSFX.play()
		LEVELUP:
			$LevelUpSFX.play()
		SHOOT:
			$ShootSFX.play()
