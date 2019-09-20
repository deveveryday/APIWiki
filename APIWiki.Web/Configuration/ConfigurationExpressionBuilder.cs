using System;
using System.CodeDom;
using System.ComponentModel;
using System.Configuration;
using System.Web.Compilation;
using System.Web.UI;

namespace Altairis.Sewen.Wiki.Configuration {
    public class ConfigurationExpressionBuilder : ExpressionBuilder {
        private const string EXPRESSION_FORMAT_STRING = @"^[A-Za-z0-9_]+\.[A-Za-z0-9_]";

        public override object EvaluateExpression(object target, BoundPropertyEntry entry, object parsedData, ExpressionBuilderContext context) {
            return GetEvalData(entry.Expression, target.GetType(), entry.Name);
        }

        public override CodeExpression GetCodeExpression(BoundPropertyEntry entry, object parsedData, ExpressionBuilderContext context) {
            Type type1 = entry.DeclaringType;
            PropertyDescriptor descriptor1 = TypeDescriptor.GetProperties(type1)[entry.PropertyInfo.Name];
            CodeExpression[] expressionArray1 = new CodeExpression[3];
            expressionArray1[0] = new CodePrimitiveExpression(entry.Expression.Trim());
            expressionArray1[1] = new CodeTypeOfExpression(type1);
            expressionArray1[2] = new CodePrimitiveExpression(entry.Name);
            return new CodeCastExpression(descriptor1.PropertyType, new CodeMethodInvokeExpression(new
           CodeTypeReferenceExpression(base.GetType()), "GetEvalData", expressionArray1));
        }

        public override bool SupportsEvaluate {
            get { return true; }
        }

        public static object GetEvalData(string expression, Type target, string entry) {
            if (!System.Text.RegularExpressions.Regex.IsMatch(expression, EXPRESSION_FORMAT_STRING)) throw new FormatException("Unexpected format of expression.");

            // Get the requested property value
            var expressionParts = expression.Split('.');
            var value = GetConfigurationValue(expressionParts[0], expressionParts[1]);
            if (value == null) return null;

            // Get the requested return type
            var propInfo = target.GetProperty(entry);
            if (value.GetType().Equals(propInfo.PropertyType)) {
                // Type matches exactly
                return value;
            }
            else if (value.GetType().MakeArrayType().Equals(propInfo.PropertyType)) {
                // Requested type is array of the one we have
                var ctr = propInfo.PropertyType.GetConstructor(new Type[] { typeof(int) });
                var array = ctr.Invoke(new object[] { 1 }) as Array;
                array.SetValue(value, 0);
                return array;
            }
            throw new NotSupportedException("Required type mapping not supported.");
        }

        private static object GetConfigurationValue(string elementName, string attributeName) {
            // Get the ConfigurationElement value
            var propInfo = typeof(SewenWikiConfigurationSection).GetProperty(elementName);
            if (propInfo == null) throw new FormatException("Unknown configuration element name in expression.");
            var element = propInfo.GetValue(Global.Configuration, null) as ConfigurationElement;
            if (element == null) throw new FormatException("Unsupported configuration element name in expression.");

            // Get value of the attribute
            propInfo = element.GetType().GetProperty(attributeName);
            if (propInfo == null) throw new FormatException("Unknown configuration attribute name in expression.");
            return propInfo.GetValue(element, null);
        }

    }
}