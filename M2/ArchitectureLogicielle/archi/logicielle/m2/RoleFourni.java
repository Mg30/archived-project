package archi.logicielle.m2;

import java.net.Socket;

public class RoleFourni {
	protected Socket sock;
	
	public RoleFourni() {
		super();
	}
	
	public Socket getSocket() {
		return this.sock;
	}
	
	public void setSocket(Socket sock) {
		this.sock = sock;
		
	}

}
