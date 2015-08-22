package mx.com.nok.obra.dao.ibatis;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import mx.com.nok.obra.dao.ObraDAO;
import mx.com.nok.obra.model.dto.EmpleadoDisponibleDTO;
import mx.com.nok.obra.model.dto.EmpleadosAsignadosObraDTO;
import mx.com.nok.obra.model.dto.EquiposAsignadosObraDTO;
import mx.com.nok.obra.model.dto.ObraDTO;
import mx.com.nok.obra.model.dto.ObraRecursoEquipoDTO;
import mx.com.nok.obra.model.dto.ObraRecursoMaquneDTO;
import mx.com.nok.obra.model.dto.ObraRecursoPersonaDTO;
@SuppressWarnings("unchecked")
public class ObraDAOImpl extends SqlMapClientDaoSupport implements ObraDAO {

	public List<?> infoObra(ObraDTO dto) throws Exception {
		return this.getSqlMapClientTemplate().
				queryForList("infoObra",dto);
	}
	
	public ObraDTO insertObra(ObraDTO dto) throws Exception {
		
		return (ObraDTO)this.getSqlMapClientTemplate().
				queryForObject("insertObra",dto);
	}

	
	public ObraDTO updateObra(ObraDTO dto) throws Exception {
		return (ObraDTO)this.getSqlMapClientTemplate().
				queryForObject("updateObra",dto);
	}
	
	public boolean deleteObra(ObraDTO dto) throws Exception {
		return (Boolean)this.getSqlMapClientTemplate().
				queryForObject("deleteObra",dto);
	}
	
	
	public List<?> infoObraRecursoMaqune(ObraRecursoMaquneDTO dto)
			throws Exception {
		return this.getSqlMapClientTemplate().
		queryForList("infoObraRecursoMaqune",dto);
	}

	
	public ObraRecursoMaquneDTO insertObraRecursoMaqune(ObraRecursoMaquneDTO dto)
			throws Exception {
		return (ObraRecursoMaquneDTO)this.getSqlMapClientTemplate().
		queryForObject("insertObraRecursoMaqune",dto);
	}
	
	public ObraRecursoMaquneDTO updateObraRecursoMaqune(ObraRecursoMaquneDTO dto)
			throws Exception {
		return (ObraRecursoMaquneDTO)this.getSqlMapClientTemplate().
		queryForObject("updateObraRecursoMaqune",dto);
	}
	
	public boolean deleteObraRecursoMaqune(ObraRecursoMaquneDTO dto)
	throws Exception {
		return (Boolean)this.getSqlMapClientTemplate().
		queryForObject("deleteObraRecursoMaqune",dto);
	}

	@Override
	public ObraRecursoEquipoDTO insertObraRecursoEquipo(ObraRecursoEquipoDTO dto)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ObraRecursoEquipoDTO updateObraRecursoEquipo(ObraRecursoEquipoDTO dto)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<?> infoObraRecursoEquipo(ObraRecursoEquipoDTO dto)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteObraRecursoEquipo(ObraRecursoEquipoDTO dto)
			throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ObraRecursoPersonaDTO insertObraRecursoPersona(
			ObraRecursoPersonaDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ObraRecursoPersonaDTO updateObraRecursoPersona(
			ObraRecursoPersonaDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<?> infoObraRecursoPersona(ObraRecursoPersonaDTO dto)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteObraRecursoEquipo(ObraRecursoPersonaDTO dto)
			throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	
	@Override
	public List<EmpleadoDisponibleDTO> infoEmpleadoDisponible(EmpleadoDisponibleDTO dto)
			throws Exception {
		return this.getSqlMapClientTemplate().
				queryForList("infoEmpleadoDisponible",dto);
		//return null;
	}
	@Override
	public List<EquiposAsignadosObraDTO> infoEquiposAsignadosObra(EquiposAsignadosObraDTO dto)
	throws Exception{
		return this.getSqlMapClientTemplate().queryForList("infoEquiposAsignadosObra",dto);
	}
	
	@Override
	public List<EmpleadosAsignadosObraDTO> infoEmpleadosAsignadosObra(EmpleadosAsignadosObraDTO dto)
	throws Exception{
		return this.getSqlMapClientTemplate().queryForList("infoEmpleadosAsignadosObra", dto);
	}

	@Override
	public boolean cambiaEstatusEmpleado(
			EmpleadosAsignadosObraDTO dto) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("LOG->DAOimple-"+dto.getEstatus());
		boolean salida;
		salida = (boolean)this.getSqlMapClientTemplate().queryForObject("cambiaEstatusEmpleado", dto);
		System.out.println("LOG-> Dao implementacion -> "+salida);
		return salida;
	}
	
	
	@Override
	public boolean cambiaEstatusEquipo(EquiposAsignadosObraDTO dto) throws Exception
	{
		boolean salida;
		salida = (boolean)this.getSqlMapClientTemplate().queryForObject("cambiaEstatusEquipo", dto);
		return salida;
	}
	
	@Override
	public boolean addEquipo(EquiposAsignadosObraDTO dto) throws Exception{
		return (boolean)this.getSqlMapClientTemplate().queryForObject("addEquipo", dto);
	}
	
	@Override
	public boolean addEmpleado(EmpleadosAsignadosObraDTO dto) throws Exception{
		return (boolean)this.getSqlMapClientTemplate().queryForObject("addEmpleado", dto);
	}
	
	@Override
	public String getEstausEmpleado(EmpleadosAsignadosObraDTO dto){
		return (String)this.getSqlMapClientTemplate().queryForObject("utilEmpleadoEstatus",dto);
	}
	

}
