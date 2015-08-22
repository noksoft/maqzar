package mx.com.nok.equipo.model.dto;

import java.util.Date;
import java.util.List;
/*
 * author Carlos Zaragoza
 * description Clase Diagnostico.
 * */
public class DiagnosticoDTO {
	private int id_diagnostico;
	private int id_equipo;
	private Date fecha_diagnostico;
	private int estatus_ingreso;
	private int usuario;
	private List<DiagnosticoDetalle> detalle;
	public int getId_diagnostico() {
		return id_diagnostico;
	}
	public void setId_diagnostico(int id_diagnostico) {
		this.id_diagnostico = id_diagnostico;
	}
	public int getId_equipo() {
		return id_equipo;
	}
	public void setId_equipo(int id_equipo) {
		this.id_equipo = id_equipo;
	}
	public Date getFecha_diagnostico() {
		return fecha_diagnostico;
	}
	public void setFecha_diagnostico(Date fecha_diagnostico) {
		this.fecha_diagnostico = fecha_diagnostico;
	}
	public int getEstatus_ingreso() {
		return estatus_ingreso;
	}
	public void setEstatus_ingreso(int estatus_ingreso) {
		this.estatus_ingreso = estatus_ingreso;
	}
	public int getUsuario() {
		return usuario;
	}
	public void setUsuario(int usuario) {
		this.usuario = usuario;
	}
	public List<DiagnosticoDetalle> getDetalle() {
		return detalle;
	}
	public void setDetalle(List<DiagnosticoDetalle> detalle) {
		this.detalle = detalle;
	}
	
	
	
}
