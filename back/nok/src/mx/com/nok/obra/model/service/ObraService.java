package mx.com.nok.obra.model.service;

import java.util.List;

import mx.com.nok.asignacion.model.dto.AsignacionDTO;
import mx.com.nok.obra.model.dto.EmpleadosAsignadosObraDTO;
import mx.com.nok.obra.model.dto.EquiposAsignadosObraDTO;
import mx.com.nok.obra.model.dto.ObraDTO;
import mx.com.nok.obra.model.dto.ObraRecursoEquipoDTO;
import mx.com.nok.obra.model.dto.ObraRecursoPersonaDTO;

public interface ObraService {

	
	public ObraDTO insertObra(ObraDTO dto);
	public ObraDTO updateObra(ObraDTO dto);
	public List<?> infoObra(ObraDTO dto);
	public boolean deleteObra(ObraDTO dto);
	
	public ObraRecursoEquipoDTO insertObraRecursoEquipo(ObraRecursoEquipoDTO dto);
	public ObraRecursoEquipoDTO updateObraRecursoEquipo(ObraRecursoEquipoDTO dto);
	public List<?> infoObraRecursoEquipo(ObraRecursoEquipoDTO dto);
	public boolean deleteObraRecursoEquipo(ObraRecursoEquipoDTO dto);
	
	public ObraRecursoPersonaDTO insertObraRecursoPersona(ObraRecursoPersonaDTO dto);
	public ObraRecursoPersonaDTO updateObraRecursoPersona(ObraRecursoPersonaDTO dto);
	public List<?> infoObraRecursoPersona(ObraRecursoPersonaDTO dto);
	public boolean deleteObraRecursoEquipo(ObraRecursoPersonaDTO dto);
	
	public List<AsignacionDTO> infoAsignacionesDisponiblesObra(AsignacionDTO dto);
	/*
	public List<EmpleadoDisponibleDTO> infoEmpleadoDisponible(EmpleadoDisponibleDTO dto);
	public List<EquiposAsignadosObraDTO> infoEquiposAsignadosObra(EquiposAsignadosObraDTO dto);
	*/
	public List<EmpleadosAsignadosObraDTO> infoEmpleadosAsignadosObra(EmpleadosAsignadosObraDTO dto);
	
	public boolean cambiaEstatusEmpleado(EmpleadosAsignadosObraDTO dto);
	
	public boolean cambiaEstatusEquipo(EquiposAsignadosObraDTO dto); 
	
	public boolean addEquipo(EquiposAsignadosObraDTO dto);
	
	public boolean addEmpleado(EmpleadosAsignadosObraDTO dto);
	
	
}
