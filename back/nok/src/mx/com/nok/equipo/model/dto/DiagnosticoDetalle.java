package mx.com.nok.equipo.model.dto;
/*
 * author Carlos Zaragoza
 * description Clase Diagnostico Detalle.
 * */
public class DiagnosticoDetalle {
	private int id_diagnostico_detalle;
	private int subcategoria;
	private int estatus_detalle;
	private String comentario;
	
	public int getId_diagnostico_detalle() {
		return id_diagnostico_detalle;
	}
	public void setId_diagnostico_detalle(int id_diagnostico_detalle) {
		this.id_diagnostico_detalle = id_diagnostico_detalle;
	}
	public int getSubcategoria() {
		return subcategoria;
	}
	public void setSubcategoria(int subcategoria) {
		this.subcategoria = subcategoria;
	}
	public int getEstatus_detalle() {
		return estatus_detalle;
	}
	public void setEstatus_detalle(int estatus_detalle) {
		this.estatus_detalle = estatus_detalle;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
}
