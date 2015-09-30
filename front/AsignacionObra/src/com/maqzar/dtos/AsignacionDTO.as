package com.maqzar.dtos
{
	[Bindable]
	[RemoteClass(alias="mx.com.nok.asignacion.model.dto.AsignacionDTO")]
	public class AsignacionDTO
	{
		private var tipoAsignacion:String;
		private var idObra:String;
		private var nombreObra:String;
		private var descripcionObra:String;
		private var idEmpleado:String;
		private var nombre:String;
		private var paterno:String;
		private var materno:String;
		private var nombreCompleto:String;
		private var idEquipo:String;
		private var numeroeconomico:String;
		private var descripcion:String;
		private var tipocategoria:String;
		private var categoria:String;
		private var subcategoria:String;
		private var estatus:Boolean;
		private var habilidades:String;
		private var typeQuery:String;
		public function AsignacionDTO()
		{
		}
	}
}