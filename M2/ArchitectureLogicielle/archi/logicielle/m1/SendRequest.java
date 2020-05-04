package archi.logicielle.m1;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;

import archi.logicielle.m2.ServiceFourni;

public class SendRequest extends ServiceFourni {
	
	public void execute (String request) throws IOException {
		OutputStream outputStream = this.sock.getOutputStream();
		ObjectOutputStream objectOutputStream = new ObjectOutputStream(outputStream);
		System.out.println("Envoie du message: " + request);
		objectOutputStream.writeObject(request);
		this.sock.close();
	}

}
