package archi.logicielle.m2;

public abstract class Composant {
	protected Interface requise;
	protected Interface fournie;
	
	public Composant() {
		super();
	}

	public Interface getRequise() {
		return requise;
	}

	public void setRequise(Interface requise) {
		this.requise = requise;
	}

	public Interface getFournie() {
		return fournie;
	}

	public void setFournie(Interface fournie) {
		this.fournie = fournie;
	}
	

}
