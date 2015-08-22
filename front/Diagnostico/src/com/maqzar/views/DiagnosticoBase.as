package com.maqzar.views
{
	import com.maqzar.models.AsignacionModel;
	
	import spark.components.Group;
	
	public class DiagnosticoBase extends Group
	{
		[Inject]
		[Bindable]
		public var asignacionModel:AsignacionModel;
		
		private var view:DiagnosticoPrincipal = DiagnosticoPrincipal(this);
		public function DiagnosticoBase()
		{
			super();
		}
	}
}