using System.Data.SqlTypes;
using System.Text.RegularExpressions;
using Microsoft.SqlServer.Server;

public static partial class UserDefinedFunctions
{

    [SqlFunction]
    public static SqlString RegexReplaceRecursive(SqlChars input, SqlString pattern, SqlChars replacement)
    {
        string output = new string( input.Value );
        Regex regex = new Regex(pattern.Value, Options);
        while (regex.IsMatch( output ))
        {
            output = regex.Replace(output, new string(replacement.Value));
        }
        return output;
    }
}