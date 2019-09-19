package backend;

import lejos.hardware.motor.EV3LargeRegulatedMotor;

import lejos.hardware.port.MotorPort;
import lejos.hardware.port.Port;
import lejos.hardware.port.SensorPort;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.robotics.RegulatedMotor;

import backend.CapteurContact;

/**
 * Classe qui permet d'offrir les différents services de l'application.
 * Les services appels les classes qui s'occupent de l'infrastructure 
 * comme la base de données ou les componsants du robot.
 */




public class VehiculeController {

    EV3LargeRegulatedMotor moteurDroite;
    EV3LargeRegulatedMotor moteurGauche;
    int speed;
    int angle;
    CapteurContact myCapteur;
    boolean stop; 
 
    public VehiculeController()
	{
        /**
         * Initialisation des composants
         */
    	
    	this.moteurDroite = new EV3LargeRegulatedMotor(MotorPort.A);
    	this.moteurGauche = new EV3LargeRegulatedMotor(MotorPort.B);
    	EV3UltrasonicSensor capteur = new EV3UltrasonicSensor(SensorPort.S3);	
    	this.myCapteur = new CapteurContact(capteur);
    	RegulatedMotor sync[] = {this.moteurDroite};
    	this.moteurGauche.synchronizeWith(sync);
    	this.speed = 10;
    	this.angle = 10;
    	this.stop = false;
    	

	}

    public void avancer() {
    	this.moteurGauche.startSynchronization();
    	if(!this.moteurDroite.isMoving() && !this.moteurGauche.isMoving()) {
    		this.moteurGauche.setSpeed(this.speed);
    		this.moteurDroite.setSpeed(this.speed);
    		this.moteurGauche.forward();
    		this.moteurDroite.forward();
    	}
    	else {
    		int newSpeed = this.moteurGauche.getSpeed() + this.speed;
    		this.moteurGauche.setSpeed(newSpeed);
    		this.moteurDroite.setSpeed(newSpeed);
    		
    	}
    	this.moteurGauche.endSynchronization();

    }

    public void reculer() {
    	this.moteurGauche.startSynchronization();
    	
    	if(this.moteurDroite.isMoving() && this.moteurGauche.isMoving()) {
    		this.moteurGauche.stop();
    		this.moteurDroite.stop();
    	}
		this.moteurGauche.setSpeed(this.speed);
		this.moteurDroite.setSpeed(this.speed);
  		this.moteurDroite.backward();
		this.moteurGauche.backward();
    	this.moteurGauche.endSynchronization();
  
    }

    public void tournerDroite() throws InterruptedException {
    	int oldSpeed = this.moteurGauche.getSpeed();
    	int newSpeed = (oldSpeed + this.speed)*2;
    	this.moteurGauche.setSpeed(newSpeed);
    	Thread.sleep(1000);
		this.moteurGauche.startSynchronization();
    	this.moteurGauche.setSpeed(oldSpeed);
    	this.moteurDroite.setSpeed(oldSpeed);
    	this.moteurGauche.endSynchronization();

    }

    public void tournerGauche() throws InterruptedException {
    	int oldSpeed = this.moteurDroite.getSpeed();
    	int newSpeed = (oldSpeed + this.speed)*2;
    	this.moteurDroite.setSpeed(newSpeed);
    	Thread.sleep(1000);
		this.moteurGauche.startSynchronization();
		this.moteurDroite.setSpeed(oldSpeed);
		this.moteurGauche.setSpeed(oldSpeed);
    	this.moteurGauche.endSynchronization();
    }

    public void decelerer() {
    	this.moteurGauche.startSynchronization();
    	int newSpeed = this.moteurGauche.getSpeed() - this.speed;
    	this.moteurGauche.setSpeed(newSpeed);
    	this.moteurDroite.setSpeed(newSpeed);
    	this.moteurGauche.endSynchronization();
    }

    public void stop() {
    	this.moteurGauche.startSynchronization();
    	this.moteurDroite.stop();
    	this.moteurGauche.stop();
    	this.moteurGauche.endSynchronization();
    	this.stop = true;
    	this.speed = 0;
    }
    
    public void auto() {
    	int distance = 0;
    	this.avancer();
    	myCapteur.start();
    	while(!this.stop) {
    		distance = myCapteur.getDistance();
    		if(distance < 25) {
    			try {
					this.tournerDroite();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
    		}
    		else {
    			this.moteurGauche.startSynchronization();
				this.moteurDroite.setSpeed(35);
				this.moteurGauche.setSpeed(35);
				this.moteurGauche.endSynchronization();
    		}
    	}
    	myCapteur.stop();
    	this.stop();
    }

	public int getSpeed() {
		return this.speed;
	}
 }