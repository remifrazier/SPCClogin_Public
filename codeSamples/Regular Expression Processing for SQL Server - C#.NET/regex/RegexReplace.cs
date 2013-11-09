using System.Data.SqlTypes;
using System.Text.RegularExpressions;
using Microsoft.SqlServer.Server;

public static partial class UserDefinedFunctions
{

    [SqlFunction]
    public static SqlString RegexReplace(SqlChars input, SqlString pattern, SqlChars replacement)
    {
        Regex regex = new Regex(pattern.Value, Options);
        
        return regex.Replace(new string(input.Value),new string(replacement.Value));
        ///return regex.IsMatch(new string(input.Value)); ///The SQL datatype here is a BIT 
    }
}