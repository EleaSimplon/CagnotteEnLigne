<?php

namespace App\Entity;

use App\Repository\CampaignRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=CampaignRepository::class)
 */
class Campaign
{
      /**
     * @var string
     *
     * @ORM\Column(name="id", type="string")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="CUSTOM")
     * @ORM\CustomIdGenerator(class="Doctrine\Bundle\DoctrineBundle\IdGenerator")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=120)
     */
    private $campaignName;

    /**
     * @ORM\Column(type="text")
     */
    private $campaignContent;

    /**
     * @ORM\Column(type="integer")
     */
    private $campaignGoal;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $name;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $email;

    /**
     * @ORM\OneToMany(targetEntity=Participant::class, mappedBy="campaignId")
     */
    private $participants;

    /**
     * @ORM\ManyToOne(targetEntity=User::class)
     * @ORM\JoinColumn(nullable=false)
     */
    private $user;

    /**
     * @ORM\OneToMany(targetEntity=Image::class, mappedBy="campaign", orphanRemoval=true, cascade={"persist"})
     */
    private $images;

    public function __construct()
    {
        $this->participants = new ArrayCollection();
        $this->images = new ArrayCollection();
    }

    public function getId(): ?string
    {
        return $this->id;
    }

    public function getCampaignName(): ?string
    {
        return $this->campaignName;
    }

    public function setCampaignName(string $campaignName): self
    {
        $this->campaignName = $campaignName;

        return $this;
    }

    public function getCampaignContent(): ?string
    {
        return $this->campaignContent;
    }

    public function setCampaignContent(string $campaignContent): self
    {
        $this->campaignContent = $campaignContent;

        return $this;
    }

    public function getCampaignGoal(): ?int
    {
        return $this->campaignGoal;
    }

    public function setCampaignGoal(int $campaignGoal): self
    {
        $this->campaignGoal = $campaignGoal;

        return $this;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): self
    {
        $this->email = $email;

        return $this;
    }

    /**
     * @return Collection|Participant[]
     */
    public function getParticipants(): Collection
    {
        return $this->participants;
    }

    public function addParticipant(Participant $participant): self
    {
        if (!$this->participants->contains($participant)) {
            $this->participants[] = $participant;
            $participant->setCampaignId($this);
        }

        return $this;
    }

    public function removeParticipant(Participant $participant): self
    {
        if ($this->participants->removeElement($participant)) {
            // set the owning side to null (unless already changed)
            if ($participant->getCampaignId() === $this) {
                $participant->setCampaignId(null);
            }
        }

        return $this;
    }

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): self
    {
        $this->user = $user;

        return $this;
    }

    /**
     * @return Collection|Image[]
     */
    public function getImages(): Collection
    {
        return $this->images;
    }

    public function addImage(Image $image): self
    {
        if (!$this->images->contains($image)) {
            $this->images[] = $image;
            $image->setCampaign($this);
        }

        return $this;
    }

    public function removeImage(Image $image): self
    {
        if ($this->images->removeElement($image)) {
            // set the owning side to null (unless already changed)
            if ($image->getCampaign() === $this) {
                $image->setCampaign(null);
            }
        }

        return $this;
    }
    
}
