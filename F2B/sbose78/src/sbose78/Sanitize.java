package sbose78;

public class Sanitize{
	public static String removeTags(String s)
	{
		String parsed="";
		for(int i=0;i<s.length();i++)
		{
			if(i<=s.length()-3 && s.charAt(i)=='<' && s.charAt(i+1)=='p' && s.charAt(i+2)=='>' )
			{	
				parsed+="\n\n";
				i+=2;
			}
			else {
				parsed+=s.charAt(i);
			}
		}
		return parsed;
	}
}
