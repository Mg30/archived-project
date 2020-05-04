package archi.logicielle.m2;
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

public abstract class ServiceFourni {
	protected Socket sock;
	
	public ServiceFourni() {
		super();
	}
	
	public void attachTo(RoleRequis role) throws UnknownHostException, IOException {
		Integer port = role.getPort();
		this.sock = new Socket("localhost", port);
	}

}
