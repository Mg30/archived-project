package archi.logicielle.m2;

import java.io.IOException;

public abstract class Connector {
	protected RoleRequis roleRequis;
	protected RoleFourni roleFournis;
	
	public Connector(RoleRequis roleRequis, RoleFourni roleFournis) {
		super();
		this.roleRequis = roleRequis;
		this.roleFournis = roleFournis;
	}

	public abstract void glue() throws IOException;
}
