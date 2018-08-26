<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<add>
		<xsl:for-each select="/tagfile/compound/docanchor">
			<doc>
				<field name="type">anchor</field>
				<field name="name"><xsl:value-of select="." /></field>
				<field name="url"><xsl:value-of select="@file" /><xsl:text>.html</xsl:text></field>
				<field name="keywords">reference anchor</field>
				<field name="text"><xsl:value-of select="@title" /></field>
			</doc>
		</xsl:for-each>
		</add>
	</xsl:template>
</xsl:stylesheet>

