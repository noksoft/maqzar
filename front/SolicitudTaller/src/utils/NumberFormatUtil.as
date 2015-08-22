package utils
{
	import mx.controls.Alert;
	import mx.formatters.NumberFormatter;

	public class NumberFormatUtil
	{
		public function NumberFormatUtil()
		{
		}
		
		/**
		 * Formats a number value using the precision and thousand separator specified 
		 * @param value
		 * @param precision
		 * @param useThousandsSeparator
		 * @param separator
		 * @return 
		 * 
		 */
		public static function formatThousandsNumber(value:Number, precision:int = 0, useThousandsSeparator:Boolean = true, separator:String = ',', round:String = 'nearest'):String{
			var format:NumberFormatter = new NumberFormatter();
			format.precision = precision;
			format.useThousandsSeparator = useThousandsSeparator;
			format.thousandsSeparatorTo = separator;
			format.rounding = round;
			
			if(value){
				return format.format(value);
			}
			
			return "0";
		}
	}
}