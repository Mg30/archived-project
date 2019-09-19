package backend;

import lejos.robotics.RegulatedMotor;

public class Moteur {
	/**
	 * Classe qui permet de gérer la communication avec le componsant moteur du robot via l'api EV3
	 */

	private RegulatedMotor moteur;
	private int vitesseDeBase;

	public Moteur(RegulatedMotor moteur) {
		// Constructeur
		this.moteur = moteur;
		this.vitesseDeBase =10;
	}

	public void avancer(RegulatedMotor[] sync ){
		this.moteur.synchronizeWith(sync);
		RegulatedMotor otherMotor = sync[0];
		this.moteur.startSynchronization();
		if(!this.moteur.isMoving()) {
			this.moteur.setAcceleration(this.vitesseDeBase);
			otherMotor.setAcceleration(this.vitesseDeBase);
			this.moteur.setSpeed(this.vitesseDeBase);
			otherMotor.setSpeed(this.vitesseDeBase);
		    this.moteur.forward();
			}
		this.moteur.endSynchronization();

		 

	}

	public void reculer(){
		if (this.moteur.isMoving()) {
			this.moteur.stop();
			this.moteur.setSpeed(this.vitesseDeBase);
			this.moteur.backward();
		}
		else {
			this.moteur.setSpeed(this.vitesseDeBase);
			this.moteur.backward();
		}



	}

	public void accelerer(){
		if(this.moteur.isMoving()) {
			this.moteur.setAcceleration(this.vitesseDeBase);
		}
		
	}


	public void tourner(int angle) {
		if(this.moteur.isMoving()) {
			this.moteur.setAcceleration(this.vitesseDeBase);

		}
		else {
			this.moteur.rotate(angle);
		}
		
	}


	public void stop() {
		this.moteur.stop();
		
	}




}
