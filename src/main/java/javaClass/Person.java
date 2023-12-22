package javaClass;

public class Person {
	private static Person instance;
	public int id;
	public String cpf;
	public String password; 
	public String name;
	
	private Person() {}
	
	public static Person getInstance() {
		if(instance == null){
			instance = new Person();
		}
		return instance;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
}
