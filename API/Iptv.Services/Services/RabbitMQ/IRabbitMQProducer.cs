namespace Iptv.Services
{
    public interface IRabbitMQProducer
    {
        public void SendMessage<T>(T message);
    }
}

