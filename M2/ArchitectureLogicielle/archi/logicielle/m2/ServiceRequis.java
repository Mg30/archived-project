package archi.logicielle.m2;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;

public abstract class ServiceRequis {
	protected ServerSocket sock;
	protected Integer port;
	
	public ServiceRequis(Integer port) throws IOException {
		super();
		this.port = port;
		this.sock= new ServerSocket(this.port);
	}
	public void attachTo(RoleFourni role) throws UnknownHostException, IOException {
		Socket sock = new Socket("localhost", this.port);
		role.setSocket(sock);
	}

}
