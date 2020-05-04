package archi.logicielle.m0;

import java.io.IOException;

import archi.logicielle.m1.Called;
import archi.logicielle.m1.Caller;
import archi.logicielle.m1.Client;
import archi.logicielle.m1.RPC;
import archi.logicielle.m1.ReceiveRequest;
import archi.logicielle.m1.SendRequest;
import archi.logicielle.m1.Serveur;
import archi.logicielle.m2.Composant;
import archi.logicielle.m2.Interface;

public class Main {

	public static void main(String[] args) throws IOException, ClassNotFoundException {
		
		
		Composant serveur = new Serveur();
		ReceiveRequest receivedRequest = new ReceiveRequest(8005);
		Interface requise = new Interface(receivedRequest);
		serveur.setRequise(requise);
		
		
		Composant client = new Client();
		SendRequest sendRequest = new SendRequest();
		Interface fournie = new Interface(sendRequest);
		client.setFournie(fournie);
		
		
		Caller caller = new Caller(8000);
		Called called = new Called();
		
		
		sendRequest.attachTo(caller);
		receivedRequest.attachTo(called);
		
		
		RPC rpc = new RPC(caller,called);
		rpc.glue();
		
		
		sendRequest.execute("requête");
		receivedRequest.printRequest();
	}

}
