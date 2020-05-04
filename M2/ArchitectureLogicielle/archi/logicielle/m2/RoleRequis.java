package archi.logicielle.m2;

import java.io.IOException;
import java.net.ServerSocket;

public abstract class RoleRequis {
	protected ServerSocket sock;
	protected Integer port;
	
	public RoleRequis(Integer port) throws IOException {
		super();
		this.port = port;
		this.sock= new ServerSocket(this.port);
	}

	public Integer getPort() {
		return port;
	}
	
	public ServerSocket getSock() {
		return sock;
	}

	
}

