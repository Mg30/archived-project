package archi.logicielle.m2;

public class Interface {
	ServiceFourni serviceFourni;
	ServiceRequis serviceRequis;
	
	public Interface(ServiceFourni serviceFourni) {
		super();
		this.serviceFourni = serviceFourni;
	}
	
	public Interface(ServiceRequis serviceRequis) {
		super();
		this.serviceRequis = serviceRequis;
	}

	public ServiceFourni getServiceFourni() {
		return serviceFourni;
	}

	public void setServiceFourni(ServiceFourni serviceFourni) {
		this.serviceFourni = serviceFourni;
	}

	public ServiceRequis getServiceRequis() {
		return serviceRequis;
	}

	public void setServiceRequis(ServiceRequis serviceRequis) {
		this.serviceRequis = serviceRequis;
	}
	
}
