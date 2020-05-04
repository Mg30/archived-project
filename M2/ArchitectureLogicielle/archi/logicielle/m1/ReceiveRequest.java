package archi.logicielle.m1;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.net.Socket;

import archi.logicielle.m2.ServiceRequis;

public class ReceiveRequest extends ServiceRequis {

	public ReceiveRequest(Integer port) throws IOException {
		super(port);
		// TODO Auto-generated constructor stub
	}
	
	public void printRequest() throws IOException, ClassNotFoundException {
		Socket from = this.sock.accept();
	    InputStream inputStream = from.getInputStream();
	    ObjectInputStream objectInputStream = new ObjectInputStream(inputStream);
	    String message = (String) objectInputStream.readObject();
	    System.out.println("Message reçu : " + message);
	    this.sock.close();
	}

}
