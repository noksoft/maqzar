package mx.com.nok.equipo.model.service;

import java.util.List;

import mx.com.nok.equipo.model.dto.DiagnosticoDTO;

public interface DiagnositicoService {
	public DiagnosticoDTO insertDiagnostico(DiagnosticoDTO dto);
	public DiagnosticoDTO updateDiagnostico(DiagnosticoDTO dto);
	public boolean deleteDiagnostico(DiagnosticoDTO dto);
	public List<?> infoDiagnostico(DiagnosticoDTO dto);
}