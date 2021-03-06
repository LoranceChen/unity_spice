#if !BESTHTTP_DISABLE_ALTERNATE_SSL

using System;

namespace Org.BouncyCastle.Crypto.Tls
{
    public interface IClientCredentialsProvider
    {
        TlsCredentials GetClientCredentials(CertificateRequest certificateRequest);
    }

	/// <summary>
	/// A temporary class to wrap old CertificateVerifyer stuff for new TlsAuthentication.
	/// </summary>
	public class LegacyTlsAuthentication : TlsAuthentication
	{
		protected ICertificateVerifyer verifyer;
        protected IClientCredentialsProvider credProvider;
        protected Uri TargetUri;

		public LegacyTlsAuthentication(Uri targetUri, ICertificateVerifyer verifyer, IClientCredentialsProvider prov)
		{
            this.TargetUri = targetUri;
			this.verifyer = verifyer;
            this.credProvider = prov;
		}

		public virtual void NotifyServerCertificate(Certificate serverCertificate)
		{
			if (!this.verifyer.IsValid(this.TargetUri, serverCertificate.GetCertificateList()))
				throw new TlsFatalAlert(AlertDescription.user_canceled);
		}

		public virtual TlsCredentials GetClientCredentials(CertificateRequest certificateRequest)
		{
			return credProvider == null ? null : credProvider.GetClientCredentials(certificateRequest);
		}
	}
}

#endif
