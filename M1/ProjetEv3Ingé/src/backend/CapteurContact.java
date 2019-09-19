package backend;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.robotics.SampleProvider;

public class CapteurContact extends Thread {

	  /**
     * Classe qui permet de gérer le capteur de contact
     * pour savoir si le robot peut exécuter les mouvements de base
     */
    private EV3UltrasonicSensor capteur;
    private final SampleProvider distanceMode;
    private final float[] distanceSample;


    public CapteurContact(EV3UltrasonicSensor capteur) {
        /**
         * Constructeur de la classe capteur contact
         * On recupère le mode distance qui va nous permettre de mesurer
         * la distance.
         */
        this.capteur = capteur;
        this.capteur.enable();
        this.distanceMode = this.capteur.getDistanceMode();
        distanceSample = new float[distanceMode.sampleSize()];
    }
   

    public int getDistance() {
		distanceMode.fetchSample(distanceSample, 0);
		float result = distanceSample[0];
		return (int) (result * 100);
    }
}
