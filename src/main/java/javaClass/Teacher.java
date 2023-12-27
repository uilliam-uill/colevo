package javaClass;

public class Teacher {
	static private Teacher instance;
	public String numberClass;
	public int idTeacher;
	public int idClass;
	public String materia;
	public static Teacher getInstance() {
		if(instance == null) {
			instance = new Teacher();
		}
		return instance;
	}
	public String getNumberClass() {
		return numberClass;
	}
	public void setNumberClass(String numberClass) {
		this.numberClass = numberClass;
	}
	public int getIdTeacher() {
		return idTeacher;
	}
	public void setIdTeacher(int idTeacher) {
		this.idTeacher = idTeacher;
	}
	public int getIdClass() {
		return idClass;
	}
	public void setIdClass(int idClass) {
		this.idClass = idClass;
	}
	public String getMateria() {
		return materia;
	}
	public void setMateria(String materia) {
		this.materia = materia;
	}
	
}