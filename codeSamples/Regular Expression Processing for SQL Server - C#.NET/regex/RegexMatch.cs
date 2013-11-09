using System.Data.SqlTypes;
using System.Text.RegularExpressions;
using Microsoft.SqlServer.Server;

//This system borrows some code from a 2007 publication by David Banister.

public static partial class UserDefinedFunctions
{
   public static readonly RegexOptions Options =
       RegexOptions.IgnorePatternWhitespace |
       RegexOptions.Compiled | RegexOptions.Singleline;

   [SqlFunction]
   public static SqlBoolean RegexMatch( SqlChars input, SqlString pattern )
   {
      Regex regex = new Regex( pattern.Value, Options );
      return regex.IsMatch( new string( input.Value ) ); ///The SQL datatype here is a BIT 
   }
}