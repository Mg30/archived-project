package archi.logicielle.m1;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.Socket;

import archi.logicielle.m2.Connector;
import archi.logicielle.m2.RoleFourni;
import archi.logicielle.m2.RoleRequis;

public class RPC extends Connector {

	public RPC(RoleRequis roleRequis, RoleFourni roleFournis) {
		super(roleRequis, roleFournis);
	}

	@Override
	public void glue() throws IOException {
		Thread t = new Thread(new Runnable() {
			@Override
			public void run() {
				try {
					Socket from = roleRequis.getSock().accept();
					InputStream inputStream = from.getInputStream();
					ObjectInputStream objectInputStream = new ObjectInputStream(inputStream);
					String message = (String) objectInputStream.readObject();
					Socket to = roleFournis.getSocket();
					OutputStream outputStream = to.getOutputStream();
					ObjectOutputStream objectOutputStream = new ObjectOutputStream(outputStream);
					objectOutputStream.writeObject(message);
					from.close();
					to.close();
				} catch (ClassNotFoundException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		});
		t.start();
	}
}
